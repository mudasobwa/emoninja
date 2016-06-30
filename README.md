# Emoninja

Gem that allows emoji substitutions (amongst other handy operations) in texts.

## Installation

```ruby
gem 'emoninja'     # in Gemfile
############################
require 'emoninja' # wherever applicable
```
## Usage

    Emoninja.emojify text

## Examples:

| Original | Translated |
|----------|------------|
| A thing of beauty is a joy for ever: | A thing of beauty is a 😹 for ever:  |
| Its lovliness increases; it will never | Its lovliness increases; it will never  |
| Pass into nothingness; but still will keep | Pass into nothingness; but still will keep  |
| A bower quiet for us, and a sleep | A bower 🔕 for us, and a 🛏  |
| Full of sweet dreams, and health, and quiet breathing. | 💯 of 🍮 dreams, and health, and 🔕 breathing.  |
| Therefore, on every morrow, are we wreathing | Therefore, on every morrow, are we wreathing  |
| A flowery band to bind us to the earth, | A flowery band to bind us to the 🌐,  |
| Spite of despondence, of the inhuman dearth | Spite of despondence, of the inhuman dearth  |
| Of noble natures, of the gloomy days, | Of noble natures, of the gloomy days,  |
| Of all the unhealthy and o'er-darkn'd ways | Of all the unhealthy and 🅾'er-darkn'd ways  |
| Made for our searching: yes, in spite of all, | Made for our searching: yes, in spite of all,  |
| Some shape of beauty moves away the pall | Some shape of beauty moves away the pall  |
| From our dark spirits. Such the sun, the moon, | From our 🌑 spirits. Such the 🌤, the 🌚,  |
| Trees old and young, sprouting a shady boon | Trees 🗝 and young, sprouting a shady boon  |
| For simple sheep; and such are daffodils | For simple 🐑; and such are daffodils  |
| With the green world they live in; and clear rills | With the 📗 🌎 they live in; and clear rills  |
| That for themselves a cooling covert make | That for themselves a cooling covert make  |
| 'Gainst the hot season; the mid-forest brake, | 'Gainst the ☕ season; the mid-forest brake,  |
| Rich with a sprinkling of fair musk-rose blooms: | Rich with a sprinkling of fair musk-🌹 blooms:  |
| And such too is the grandeur of the dooms | And such too is the grandeur of the dooms  |
| We have imagined for the mighty dead; | We have imagined for the mighty dead;  |
| An endless fountain of immortal drink, | An endless ⛲ of immortal 🍾,  |
| Pouring unto us from the heaven's brink. | Pouring unto us from the heaven's brink.  |
— A Thing Of Beauty (Endymion) - Poem by John Keats

## ToDo

— flags and other combineds are not treated properly;  
— stopwords (like “us” above);  
— NLP + stemming.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/emoninja. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
