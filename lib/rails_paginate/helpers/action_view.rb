module RailsPaginate::Helpers
  module ActionView
    # view_helper for paginate
    #
    # == Options
    # :id
    # :class
    def paginate(*args)
      options = args.extract_options!

      raise ArgumentError, "first argument muss be a RailsPaginate::Collection" unless args.first.is_a? RailsPaginate::Collection

      attributes = {}
      attributes[:class] = "pagination #{options[:class]}".strip
      attributes[:id] = options[:id] unless options[:id].blank?

      content_tag :div, attributes do
        "Test"
      end
    end
  end
end
