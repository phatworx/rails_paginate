DataMapper.setup(:default, 'sqlite3::memory')

class DataMapperItem
  include DataMapper::Resource
  property :id,   Serial
  property :name, String, :required => true
end

DataMapper.auto_migrate!