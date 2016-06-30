require 'emoninja/version'
require 'emoninja/porter_stemmer'
require 'emoninja/grabber'

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
  end
end
