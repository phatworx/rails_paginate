module RailsPaginate::Renderers
  # base method
  class Base
    cattr_accessor :inner_window, :outer_window

    @@inner_window = 2
    @@outer_window = 2

    attr_reader :view, :collection, :options

    def initialize(view, collection, options = {})
      raise ArgumentError, "first argument muss be a RailsPaginate::Collection" unless collection.is_a? RailsPaginate::Collection
      raise ArgumentError, "second argument muss be a Hash" unless options.is_a? Hash
      @options = options
      @collection = collection
      @view = view
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

    def visible_pages
      visible = []
      last_found = 0
      split = false
      (1..collection.pages).each do |p|
        # insert
        if page_visible? p
          visible << p
          last_found = p
          split = false
        else
          # need splitter
          if not split and outer_window > 0 and last_found < p
            visible << nil
            split = true
          end
        end
      end
      visible
    end

    def inner_window_range
      @inner_window_range ||= (current_page - inner_window)..(current_page + inner_window)
    end

    def page_visible?(p)
      # outer
      if outer_window > 0
        return true if outer_window >= p
        return true if (collection.pages - outer_window) < p
      end

      # current page
      return true if current_page == p

      # inner
      return true if inner_window_range.include? p

      false
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