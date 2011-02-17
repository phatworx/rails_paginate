module RailsPaginate::Pagers
  # slider method
  class Slider < Base
    cattr_accessor :inner, :outer
    @@inner = 3
    @@outer = 1

    def visible_pages
      visible = []
      last_inserted = 0
      splited = false
      (1..pages).each do |page|
        # insert
        if visible? page
          visible << page
          last_inserted = page
          splited = false
        else
          # need splitter
          if not splited and outer > 0 and last_inserted < page
            visible << nil
            splited = true
          end
        end
      end
      visible
    end

    def inner_range
      @inner_range ||= (current_page - inner)..(current_page + inner)
    end

    # looks should this page visible
    def visible?(page)
      # outer
      if outer > 0
        return true if outer >= page
        return true if (pages - outer) < page
      end

      # current page
      return true if current_page == page

      # inner
      return true if inner_range.include? page

      false
    end

    def inner
      options[:inner] || self.class.inner
    end

    def outer
      options[:outer] || self.class.outer
    end

  end
end