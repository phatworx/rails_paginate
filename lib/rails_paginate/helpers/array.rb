module RailsPaginate::Helpers
  # Array extension for create paginate collection
  module Array
    # paginate with options
    #
    # page = active page
    # per_page = how much entries per page
    def paginate(*args)
      options = args.extract_options!
      per_page = options.delete(:per_page)
      page = options.delete(:page) || 1
      ::RailsPaginate::Collection.new(self, args.first || page, per_page)
    end
  end
end
