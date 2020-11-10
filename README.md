# ShoeScraper

A simple CLI application that scrapes available inventory of limited edition sneakers from indexpdx.com. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shoe_scraper'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install shoe_scraper

## Dependencies

Please note the following dependencies are needed in order for ShoeScraper to work properly. 

    
    'colorize', '>= 0.8.1'

    'nokogiri', '>= 1.10.8'

    'rake', '>= 12.0'


## Usage

Open up a session of irb 

    $ irb 

Then require the gem 

    $ require 'shoe_scraper' 

Initialize the application 

    $ ShoeScraper.new.run 

Follow the prompts and enjoy! 

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/uharston/shoe_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/shoe_scraper/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ShoeScraper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/uharston/shoe_scraper/blob/master/CODE_OF_CONDUCT.md).


