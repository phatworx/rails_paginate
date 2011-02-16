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
      "?page=#{page}"
    end

    def render
      raise StandardError, "render is not implemented"
    end

    protected

    def link_to_page(page, key, options = {})
      if page.nil?
        view.content_tag :span, :class => "link #{options[:class]}" do
          view.content_tag :span, :class => "inline" do
            view.t(key)
          end
        end
      else
        view.link_to url_for_page(page), :class => "link #{options[:class]}", :alt => view.strip_tags(view.t(key, :page => page)) do
          view.content_tag :span, :class => "inline" do
            view.t(key, :page => page)
          end
        end
      end
    end

  end
end