module RailsPaginate::Renderers
  # base method
  class Base
    attr_reader :view, :collection, :options, :pager

    def initialize(view, collection, pager, options = {})
      raise ArgumentError, "first argument must be a RailsPaginate::Collection" unless collection.is_a? RailsPaginate::Collection
      raise ArgumentError, "second argument must be a Hash" unless options.is_a? Hash
      raise ArgumentError, "third argument must be an instance of RailsPaginate::Pagers::Base" unless pager.is_a? RailsPaginate::Pagers::Base
      @options = options
      @collection = collection
      @view = view
      @pager = pager
    end

    def url_for_page(page)
      # todo: fix url_for so did't neet fallback
      begin
        view.url_for(view.default_url_options.merge({:page => page}))
      rescue
        "?page=#{page}"
      end
    end

    def render
      raise StandardError, "render is not implemented"
    end

    protected

    def link_to_page(page, key, options = {})
      css_class = "#{options[:class]} #{page == current_page ? 'current' : ''}"
      if key.nil?
        content_tag :span, "..", :class => "spacer"
      elsif page.nil?
        content_tag :span, t(key), :class => "#{css_class} unavailable"
      else
        link_to t(key, :page => page), url_for_page(page), :class => css_class, :alt => view.strip_tags(t(key, :page => page))
      end
    end

    # helper
    def current_page
      collection.current_page
    end

    def content_tag(*args, &block)
      view.content_tag(*args, &block)
    end

    def link_to(*args, &block)
      view.link_to(*args, &block)
    end

    def t(*args)
      view.t(*args)
    end

    def inner_window
      self.class.inner_window
    end

    def outer_window
      self.class.outer_window
    end

  end
end