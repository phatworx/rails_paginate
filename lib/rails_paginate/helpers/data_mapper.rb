module RailsPaginate::Helpers
  # DataMapper extension for create paginate collection
  module DataMapper
    # paginate with options
    #
    # page = active page
    # per_page = how much entries per page
    def paginate(*args)
      options = args.extract_options!
      per_page = options.delete(:per_page)
      page = options.delete(:page) || 1
      p "----------------"
      puts self.included_modules.include? ::DataMapper::Model
      p "----------------"
      ::RailsPaginate::Collection.new(self, page, per_page)
    end
  end
end
