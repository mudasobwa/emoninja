require 'spec_helper'

describe Emoninja do
  it 'has a version number' do
    expect(Emoninja::VERSION).not_to be nil
  end

  it 'returns an exact value of "GRINNING FACE"' do
    expect(Emoninja::Data.exact('grinning face')[:glyph]).to eq('😀')
  end

  it 'returns a nil for exact value of "GOOGLING FACE"' do
    expect(Emoninja::Data.exact('googling face')[:glyph]).to be_nil
  end

  it 'returns an array of glyphs for "grin"' do
    expect(Emoninja::Data.keywords('grin').size).to be >= 3
  end

  it 'returns an empty array of glyphs for "google"' do
    expect(Emoninja::Data.keywords('google').size).to be_zero
  end

  it 'should permit hashiemashing on "GRINNING FACE"' do
    expect(Emoninja::Data.exact('grinning face').glyph).to eq('😀')
  end

  it 'should return the correct emojis of "GRINNING FACE"' do
    expect(Emoninja::Data.emoji('grinning face')).to eq('😀')
    expect(Emoninja::Data.emoji('grin', exact: false, number: 0)).to eq('😁')
    10.times { print Emoninja::Data.emoji('grin', exact: false) }
    puts
    expect(Emoninja::Data.emoji('grin', exact: false).length).to eq 1
  end

  it 'translates John Keats to emojish' do
    text = <<-POEM
      A thing of beauty is a joy for ever:
      Its lovliness increases; it will never
      Pass into nothingness; but still will keep
      A bower quiet for us, and a sleep
      Full of sweet dreams, and health, and quiet breathing.
      Therefore, on every morrow, are we wreathing
      A flowery band to bind us to the earth,
      Spite of despondence, of the inhuman dearth
      Of noble natures, of the gloomy days,
      Of all the unhealthy and o'er-darkn'd ways
      Made for our searching: yes, in spite of all,
      Some shape of beauty moves away the pall
      From our dark spirits. Such the sun, the moon,
      Trees old and young, sprouting a shady boon
      For simple sheep; and such are daffodils
      With the green world they live in; and clear rills
      That for themselves a cooling covert make
      'Gainst the hot season; the mid-forest brake,
      Rich with a sprinkling of fair musk-rose blooms:
      And such too is the grandeur of the dooms
      We have imagined for the mighty dead;
      An endless fountain of immortal drink,
      Pouring unto us from the heaven's brink.
    POEM
    max_len = text.split(/\R/).max_by(&:length).length + 2
    puts '—' * max_len
    puts text
    puts '—' * max_len
    puts Emoninja.emojify(text)
    puts '—' * max_len
    puts Emoninja.yay(text)
    puts '—' * max_len
  end

  it 'translates John Lennon to emojish' do
    text = <<-POEM
      I've just seen a face
      I can't forget the time or place
      Where we just met
      She's just the girl for me
      And I want all the world to see
      We've met, mmm-mmm-mmm-m'mmm-mmm

      Had it been another day
      I might have looked the other way
      And I'd have never been aware
      But as it is I'll dream of her
      Tonight, di-di-di-di'n'di

      Falling, yes I am falling
      And she keeps calling
      Me back again

      I have never known
      The like of this, I've been alone
      And I have missed things
      And kept out of sight
      But other girls were never quite
      Like this, da-da-n'da-da'n'da

      Falling, yes I am falling
      And she keeps calling
      Me back again

      Falling, yes I am falling
      And she keeps calling
      Me back again

      I've just seen a face
      I can't forget the time or place
      Where we just met
      She's just the girl for me
      And I want all the world to see
      We've met, mmm-mmm-mmm-da-da-da

      Falling, yes I am falling
      And she keeps calling
      Me back again
      Falling, yes I am falling
      And she keeps calling
      Me back again
      Oh, falling, yes I am falling
      And she keeps calling
      Me back again
    POEM
    max_len = text.split(/\R/).max_by(&:length).length + 2
    puts '—' * max_len
    puts text
    puts '—' * max_len
    puts Emoninja.emojify(text)
    puts '—' * max_len
    puts Emoninja.yay(text)
    puts '—' * max_len
  end
end
