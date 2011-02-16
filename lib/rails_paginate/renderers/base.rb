module RailsPaginate::Renderers
  # base method
  class Base
    def render
      raise StandardError, "render is not implemented"
    end
  end
end