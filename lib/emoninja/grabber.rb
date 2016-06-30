require 'kungfuig'

require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'hashie/mash'

module Emoninja
  @data = nil

  # Utility to grab consortium’s data for emojis
  class Data
    # http://unicode.org/emoji/charts/full-emoji-list.html
    DATA_HTML = 'http://unicode.org/emoji/charts/full-emoji-list.html'.freeze
    LOCAL_CACHE = File.join __dir__, '..', '..', 'data', 'full-emoji-list.html'
    LOCAL_DATA = File.join __dir__, '..', '..', 'data', 'emojis.yml'

    include Kungfuig

    def initialize
      # @file ||= File.exist?(LOCAL_DATA) &&
      # return @file if @file
    end

    def self.data
      return @data if @data

      unless File.exist?(LOCAL_CACHE)
        open(DATA_HTML) do |f|
          File.write(LOCAL_CACHE, f.read)
        end
      end

      @data = begin
        if File.exist?(LOCAL_DATA)
          YAML.load File.read LOCAL_DATA
        else
          Nokogiri::HTML(open(LOCAL_CACHE)).xpath('//table/tr').tap(&:shift).map do |tr|
            {
              name: tr.children[30].text,
              keywords: tr.children[36].text.split(',').map(&:strip),
              code: tr.children[2].text, glyph: tr.children[4].text,
              apple: blob(tr, 6), google: blob(tr, 8), twitter: blob(tr, 10),
              one: blob(tr, 12), fbm: blob(tr, 14), windows: blob(tr, 16),
              samsung: blob(tr, 18)
            }
          end.tap { |data| File.write(LOCAL_DATA, data.to_yaml) }
        end
      rescue
        File.delete(LOCAL_DATA)
        retry
      end
    end

    # @return [Hashie::Mash]
    def self.keywords term
      (cache[:keywords][term.to_s.downcase] || []).map(&data.method(:[])).map(&Hashie::Mash.method(:new))
    end

    # @return Hashie::Mash
    def self.exact term
      Hashie::Mash.new(cache[:exacts][term.to_s.downcase] ? data[cache[:exacts][term.to_s.downcase]] : {})
    end

    # @return Hash
    def self.vocabulary
      @vocabulary ||= data.map { |h| [h[:name], h[:glyph]] }.to_h
    end

    # @return Hashie::Mash
    def self.argo
      @argo ||= data.each_with_object(Hashie::Mash.new) do |h, memo|
        h[:keywords].each do |kw|
          (memo[kw] ||= []) << h[:glyph]
        end
      end
    end

    def self.emoji term, kind: :glyph, exact: false, number: nil
      match = self.exact(term)[kind]
      return match if match || exact

      return nil unless (match = argo[term])
      number ? match[number] : match.sample
    end

#    Data.kungfuig(LOCAL_DATA) do |options|
#      options.other_value = options[:value]
#    end

    class << self
      private

      def blob tr, col
        tr.children[col].children.first.attributes['src'].value rescue nil
      end

      def cache
        return @cache if @cache

        @cache = data.each_with_index.with_object(keywords: {}, exacts: {}) do |(e, i), memo|
          memo[:exacts][e[:name].downcase] = i
          e[:keywords].each do |kw|
            (memo[:keywords][kw.downcase] ||= []) << i
          end
        end
      end
    end
  end
end
