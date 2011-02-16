module RailsPaginate::Helpers
  module ActionView
    def paginate(*args)
      options = args.extract_options!
      "<b>html</b>".html_safe
    end
  end
end
