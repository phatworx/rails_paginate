module RailsPaginate::Helpers
  # ActionView extension for create paginate view helper
  module ActionView
    # view_helper for paginate
    #
    # == Options
    # :id
    # :class
    def paginate(*args)
      options = args.extract_options!

      raise ArgumentError, "first argument must be a RailsPaginate::Collection" unless args.first.is_a? RailsPaginate::Collection

      collection = args.first
#      p @controller
#      p url_for(:action => :index, :controller => :dummy)

      # renderer
      renderer = options[:renderer] || RailsPaginate.default_renderer
      pager = options[:pager] || RailsPaginate.default_pager

      attributes = {}
      attributes[:class] = "pagination #{options[:class]}".strip
      attributes[:id] = options[:id] unless options[:id].blank?

      # load classes
      renderer = RailsPaginate.renderer(renderer)
      pager = RailsPaginate.pager(pager)

      content_tag :div, attributes do
        renderer.new(self, collection, pager.new(collection), options).render
      end
    end
  end
end
