require 'forkforge'
require 'forkforge/knife/string'

require 'emoninja/version'
require 'emoninja/porter_stemmer'
require 'emoninja/grabber'
require 'emoninja/data'
require 'emoninja/i18n'

module Emoninja
  class << self
    def emojify text
      text.tap do |t|
        Data.vocabulary.each { |k, v| t.gsub!(/\b#{k}\b/i, v) }
        Data.argo.each { |k, v| t.gsub!(/\b#{k}\b/i, v.sample) if v.sample }
      end
    end

    def emoninja text
      emojify(text).gsub(/\w+/) do |m|
        case
        when Data.stopword?(m) then m
        when (result = Data.keywords(m.stem).sample) then result.glyph
        else m
        end
      end
    end
    alias_method :yay, :emoninja

    # rubocop:disable Style/MethodName
    # rubocop:disable Style/OpMethod
    def аватар text
      Data.emoji(text, exact: false, number: 0, lang: :ru)
    end

    # NB this won’t work with cased words, since `Regexp`
    #    is currently failing to match it.
    # Will fix later.
    def аватарки text
      emoninja(text.gsub(Regexp.union(I18n.ru_en.keys), I18n.ru_en))
    end
    alias_method :йо, :аватарки
    # rubocop:enable Style/OpMethod
    # rubocop:enable Style/MethodName
  end
end
