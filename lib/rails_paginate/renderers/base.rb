module RailsPaginate::Renderers
  # base method
  class Base
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

    protected

    def link_to_page(page, key, options = {})
      css_class = "link #{options[:class]} #{page == collection.current_page ? 'current' : ''}"
      if page.nil?
        view.content_tag :span, :class => css_class do
          view.content_tag :span, :class => "inline" do
            view.t(key)
          end
        end
      else
        view.link_to url_for_page(page), :class => css_class, :alt => view.strip_tags(view.t(key, :page => page)) do
          view.content_tag :span, :class => "inline" do
            view.t(key, :page => page)
          end
        end
      end
    end

  end
end