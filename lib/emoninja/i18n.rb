require 'yaml'

module Emoninja
  # Utility to translate emoji names to different languages
  module I18n
    FAIL_AFTER = 10 # attempts
    class << self
      LOCAL_I18N = File.join(__dir__, '..', '..', 'data', 'translations', '%{lang}.yml').freeze
      YT_CONFIG = File.join(__dir__, '..', '..', 'config', 'yandex_translate.yml').freeze

      # @param [String] lang the language to build a dictionary
      # @param [Array | Hash] the array of words
      def translations lang
        file = LOCAL_I18N % { lang: lang }
        (@translations ||= {})[lang] ||= preload file
        keys = [Data.vocabulary, Data.argo].map(&:keys).reduce(:|) - @translations[lang].keys
        return @translations[lang] if keys.empty?

        require 'yandex-api'
        Yandex::API::Translate.load YT_CONFIG
        errors_count = 0

        @translations[lang].merge!(
          keys.each_with_object({}) do |k, memo|
            begin
              result = Yandex::API::Translate.do(k, lang)
              memo[k] = result['text'].is_a?(Array) ? result['text'].join(' ') : result['text'] if result['code'] == 200
            rescue
              break memo if (errors_count += 1) >= FAIL_AFTER
            end
          end
        ).tap { |data| File.write(file, data.to_yaml) }
      end

      def reversed_translations lang
        (@reversed_translations ||= {})[lang] ||= translations(lang).invert.map { |k, v| [k.downcase, v.downcase] }.to_h
      end
      %i(ru).each do |m|
        class_eval <<-METH
        def #{m}_en
          reversed_translations(:#{m})
        end
        METH
      end

      def key term, lang
        !lang.nil? && lang.to_s != 'en' && reversed_translations(lang)[term.downcase] || term
      end
      alias_method :[], :key

      private

      def preload file
        File.exist?(file) ? YAML.load(File.read(file)) : {}
      end
    end
  end
end
