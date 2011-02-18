module RailsPaginate::Renderers
  # default html renderer
  class HtmlDefault < Base
    
    # show first page item
    cattr_accessor :show_first_page
    @@show_first_page = true

    # show last page item
    cattr_accessor :show_last_page
    @@show_last_page = true

    # show next page item
    cattr_accessor :show_next_page
    @@show_next_page = true

    # show previous page item
    cattr_accessor :show_previous_page
    @@show_previous_page = true

    # render html for pagination
    def render
      content_tag(:ul) do
        html = "\n"

        if show_first_page?
          html += content_tag(:li, :class => "first_page") do
            link_to_page collection.first_page, 'paginate.first_page_label'
          end
          html += "\n"
        end

        if show_previous_page?
          html += content_tag(:li, :class => "previous_page") do
            link_to_page collection.previous_page, 'paginate.previous_page_label'
          end
          html += "\n"
        end

        html += render_pager

        if show_next_page?
          html += content_tag(:li, :class => "next_page") do
            link_to_page collection.next_page, 'paginate.next_page_label'
          end
          html += "\n"
        end

        if show_last_page?
          html += content_tag(:li, :class => "last_page") do
            link_to_page collection.last_page, 'paginate.last_page_label'
          end
          html += "\n"
        end
        html.html_safe
      end
    end

    # render pager
    def render_pager
      view.reset_cycle(:paginate)

      html = ""
      visible_pages = pager.visible_pages
      visible_pages.each do |page|
        html += content_tag(:li, :class => "pager #{visible_pages.first == page ? 'first_pager' : ''} #{visible_pages.last == page ? 'last_pager' : ''} #{view.cycle("pager_even", "pager_odd", :name => :paginate)}") do
          link_to_page page, page.nil? ? nil : 'paginate.pager'
        end
        html += "\n"
      end
      html.html_safe
    end

    # show first page item?
    def show_first_page?
      options[:show_first_page] || self.class.show_first_page
    end

    # show last page item?
    def show_last_page?
      options[:show_last_page] || self.class.show_last_page
    end

    # show next page item?
    def show_next_page?
      options[:show_next_page] || self.class.show_next_page
    end

    # show previous page item?
    def show_previous_page?
      options[:show_previous_page] || self.class.show_previous_page
    end

  end
end