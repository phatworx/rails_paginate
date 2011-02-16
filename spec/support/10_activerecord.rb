ActiveRecord::Base.establish_connection({
  :adapter => (defined?(JRUBY_VERSION) ? 'jdbcsqlite3' : 'sqlite3'),
  :database => ":memory:"
})
ActiveRecord::Migrator.up(File.join(File.dirname(__FILE__), '..', 'db', 'migrate'))

class Item < ActiveRecord::Base
  scope :reverse_sort, order("dummy DESC")
end