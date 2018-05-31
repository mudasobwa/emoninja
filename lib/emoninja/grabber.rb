require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'hashie/mash'

module Emoninja
  STOPWORD_MIN_LENGTH = 3

  # Utility to grab consortium’s data for emojis
  module Grabber
    # http://unicode.org/emoji/charts/full-emoji-list.html
    DATA_HTML = 'http://unicode.org/emoji/charts/full-emoji-list.html'.freeze
    LOCAL_CACHE = File.join __dir__, '..', '..', 'data', 'full-emoji-list.html'
    LOCAL_DATA = File.join __dir__, '..', '..', 'data', 'emojis.yml'

    class << self
      # rubocop:disable Metrics/AbcSize
      def load
        unless File.exist? LOCAL_CACHE
          open(DATA_HTML) do |f|
            File.write LOCAL_CACHE, f.read
          end
        end

        @data = begin
          if File.exist? LOCAL_DATA
            YAML.load File.read LOCAL_DATA
          else
            Nokogiri::HTML(open(LOCAL_CACHE)).xpath('//table/tr').tap(&:shift).map do |tr|
              next if tr.children[28].nil? || tr.children[28].text.strip.empty?
              {
                name: tr.children[28].text,
                keywords: tr.children[28].text.split(':').map(&:strip),
                code: tr.children[2].text,
                glyph: tr.children[4].text,
                apple: blob(tr, 6),
                google: blob(tr, 8),
                twitter: blob(tr, 10),
                one: blob(tr, 12),
                fbm: blob(tr, 14),
                windows: blob(tr, 16),
                samsung: blob(tr, 18)
              }
            end.compact.tap { |data| File.write(LOCAL_DATA, data.to_yaml) }
          end
        rescue => e
          puts e.message
          File.delete(LOCAL_DATA)
          retry
        end.tap do |data|
          data.each do |h|
            next unless h[:name] =~ /≊/

            vals = h[:name].split(/≊/).map(&:strip)
            h[:name] = vals.first
            data << h.dup.tap { |nick| nick[:name] = vals.last }
          end
        end
      end
      # rubocop:enable Metrics/AbcSize

      private

      def blob tr, col
        tr.children[col].children.first.attributes['src'].value rescue nil
      end
    end
  end
end
