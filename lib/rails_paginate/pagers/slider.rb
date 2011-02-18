module RailsPaginate::Pagers
  # slider method
  class Slider < Base

    # how much pages should display around current_page
    cattr_accessor :inner
    @@inner = 3

    # how much pages should display at start and end
    cattr_accessor :outer
    @@outer = 1

    # build array with all visible pages
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

    # build dummy inner range
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

    # get option of inner
    def inner
      options[:inner] || self.class.inner
    end

    # get option of out
    def outer
      options[:outer] || self.class.outer
    end

  end
end