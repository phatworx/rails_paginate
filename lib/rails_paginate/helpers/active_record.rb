module RailsPaginate::Helpers
  # ActiveRecord extension for create paginate collection
  module ActiveRecord
    # paginate with options
    #
    # page = active page
    # per_page = how much entries per page
    def paginate(*args)
      options = args.extract_options!
      per_page = options.delete(:per_page)
      page = options.delete(:page) || 1
      ::RailsPaginate::Collection.new(self, page, per_page)
    end
  end
end
