source "http://rubygems.org"
gem "rails", "~> 3.0.0"

group :development do
  gem "autotest"
  gem "bundler"
  gem "jeweler"
  gem "rspec"
  gem "yard"
  gem "rspec-hpricot-matchers"
  if defined? JRUBY_VERSION
    gem "activerecord-jdbc-adapter"
    gem "activerecord-jdbcsqlite3-adapter"
  else
    gem 'simplecov', :require => false
    gem "sqlite3"
  end
end
