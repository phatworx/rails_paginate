require 'active_record'
class ActiveRecord::Base
  def self.paginate(*args)
    options = args.extract_options!
    per_page = options.delete(:per_page) || RailsPaginate.per_page
    page = options.delete(:page) || 1
    RailsPaginate::Collection.new(self, page, per_page)
  end
end