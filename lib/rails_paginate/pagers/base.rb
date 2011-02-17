module RailsPaginate::Pagers
  # base method
  class Base
    attr_reader :collection, :options
    def initialize(collection, options = {})
      @collection = collection
      @options = options
    end

    def current_page
      collection.current_page
    end

    def pages
      collection.pages
    end

    def visible_pages
      raise StandardError, "render is not implemented"
    end
  end
end