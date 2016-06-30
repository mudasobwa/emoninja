require 'emoninja/version'
require 'emoninja/grabber'

module Emoninja
  def self.emojify text
    text.tap do |t|
      Data.vocabulary.each { |k, v| t.gsub!(/\b#{k}\b/i, v) }
      Data.argo.each { |k, v| t.gsub!(/\b#{k}\b/i, v.sample) if v.sample }
    end
  end
end
