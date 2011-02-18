module RailsPaginate::Pagers
  # base method
  class Base
    # default reader
    attr_reader :collection, :options

    # set default collection and options
    def initialize(collection, options = {})
      @collection = collection
      @options = options
    end

    # current_page
    def current_page
      collection.current_page
    end

    # total count
    def pages
      collection.pages
    end

    # abstract
    def visible_pages
      raise StandardError, "render is not implemented"
    end
  end
end