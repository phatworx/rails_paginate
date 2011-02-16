module RailsPaginate::Helpers
  module ActionView
    def paginate(*args)
      options = args.extract_options!

      raise ArgumentError, "first argument muss be a RailsPaginate::Collection" unless args.first.is_a? RailsPaginate::Collection

      "<b>html</b>".html_safe
    end
  end
end
