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

    def render
      raise StandardError, "render is not implemented"
    end
  end
end