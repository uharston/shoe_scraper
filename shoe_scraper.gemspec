
Gem::Specification.new do |s|
    s.name        = 'shoe_scraper'
    s.version     = '0.0.8'
    s.date        = '2020-11-09'
    s.summary     = "A sneaker finder gem"
    s.description = "A gem that scrapes available sneaker inventory from the indexpdx.com website for sneaker collectors."
    s.authors     = ["Uriah Harston"]
    s.email       = 'uharston@gmail.com'
    s.files       = [ "lib/shoe_scraper.rb", 'lib/super.rb', 'lib/brand.rb', 'lib/scraper.rb', 'lib/shoe.rb', 'lib/Jordan_Edition.rb']
    s.extra_rdoc_files = ['README.md']
    s.homepage    =
      'https://rubygems.org/gems/shoe_scraper'
    s.license       = 'MIT'
    s.required_ruby_version = '>= 2.5.0'

    s.add_dependency "rake", "~> 12.0"
    s.add_dependency 'nokogiri', '1.12.5'
    s.add_dependency 'colorize', '>= 0.8.1'
  end