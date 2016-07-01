require 'kungfuig'

module Emoninja
  STOPWORD_MIN_LENGTH = 3

  # Utility to grab consortium’s data for emojis
  module Data
    include Kungfuig

    class << self
      def data
        @data ||= Grabber.load
      end

      def stopword? term
        term.length < STOPWORD_MIN_LENGTH || options[:stopwords].include?(term)
      end

      # @return [Hashie::Mash]
      def keywords term, lang: nil
        term = marshal term, lang
        (cache[:keywords][term.to_s.downcase] || []).map(&data.method(:[])).map(&Hashie::Mash.method(:new))
      end

      # @return Hashie::Mash
      def exact term, lang: nil
        term = marshal term, lang
        Hashie::Mash.new(cache[:exacts][term.to_s.downcase] ? data[cache[:exacts][term.to_s.downcase]] : {})
      end

      ##########################################################################

      # @return Hash
      def vocabulary
        @vocabulary ||= data.map { |h| [h[:name], h[:glyph]] }.to_h.reject { |k, _| stopword?(k) }
      end

      # @return Hashie::Mash
      def argo
        @argo ||= data.each_with_object(Hashie::Mash.new) do |h, memo|
          h[:keywords].each do |kw|
            (memo[kw] ||= []) << h[:glyph] unless stopword?(kw)
          end
        end
      end

      ##########################################################################

      def emoji term, kind: :glyph, exact: false, number: nil, lang: nil
        match = exact(term, lang: lang)[kind]
        return match if match || exact

        return nil unless (match = keywords(term, lang: lang).map { |kw| kw[kind] })
        number ? match[number] : match.sample
      end

      private

      def cache
        return @cache if @cache

        @cache = data.each_with_index.with_object(keywords: {}, exacts: {}) do |(e, i), memo|
          memo[:exacts][e[:name].downcase] = i
          e[:keywords].each do |kw|
            (memo[:keywords][kw.downcase] ||= []) << i
          end
        end
      end

      def marshal term, lang = nil
        return term if lang.nil? || options.translate!.languages!.none? { |l| l == lang.to_s }
        I18n.key term, lang
      end
    end

    #    Data.kungfuig(LOCAL_DATA) do |options|
    #      options.other_value = options[:value]
    #    end

    File.join(__dir__, '..', '..', 'config', 'emoninja.yml').tap do |cfg|
      kungfuig(cfg) if File.exist?(cfg)
    end
  end
end
