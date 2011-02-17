ActiveRecord::Base.establish_connection({
  :adapter => (defined?(JRUBY_VERSION) ? 'jdbcsqlite3' : 'sqlite3'),
  :database => ":memory:"
})

ActiveRecord::Schema.define(:version => 0) do
  create_table :items, :force => true do |t|
    t.column :dummy, :string
  end
end

class Item < ActiveRecord::Base
  scope :reverse_sort, order("dummy DESC")
end