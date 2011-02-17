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

      collection = args.first
#      p @controller
#      p url_for(:action => :index, :controller => :dummy)

      # renderer
      renderer = options[:renderer] || RailsPaginate.default_renderer

      attributes = {}
      attributes[:class] = "pagination #{options[:class]}".strip
      attributes[:id] = options[:id] unless options[:id].blank?

      content_tag :div, attributes do
        RailsPaginate.renderer(renderer).new(self, collection, options).render
      end
    end
  end
end
