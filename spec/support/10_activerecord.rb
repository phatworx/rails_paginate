ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => ":memory:"
})
ActiveRecord::Migrator.up(File.join(File.dirname(__FILE__), '..', 'db', 'migrate'))

class Item < ActiveRecord::Base
  scope :reverse_sort, order("dummy DESC")
end