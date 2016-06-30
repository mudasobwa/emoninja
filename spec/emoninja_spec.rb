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
    puts Emoninja.emojify(text)
  end
end
