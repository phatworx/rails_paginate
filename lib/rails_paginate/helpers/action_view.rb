module RailsPaginate::Helpers
  module ActionView
    def paginate(*args)
      options = args.extract_options!
    end
  end
end
