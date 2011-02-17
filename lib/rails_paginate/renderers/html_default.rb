module RailsPaginate::Renderers
  # normale renderer
  class HtmlDefault < Base
    # show first page item
    cattr_accessor :show_first_page
    @@show_first_page = true

    # show last page item
    cattr_accessor :show_last_page
    @@show_last_page = true

    def render
      content_tag(:ul) do
        html = "\n"

        if show_first_page?
          html += content_tag(:li, :class => "first_page") do
            link_to_page collection.first_page, 'paginate.first_page_label'
          end
          html += "\n"
        end

        html += content_tag(:li, :class => "previous_page") do
          link_to_page collection.previous_page, 'paginate.previous_page_label'
        end

        html += render_pager

        html += "\n"
        html += content_tag(:li, :class => "next_page") do
          link_to_page collection.next_page, 'paginate.next_page_label'
        end
        html += "\n"

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
      html = ""
      pager.visible_pages.each do |page|
        html += "\n"
        html += content_tag(:li, :class => "pager") do
          link_to_page page, page.nil? ? nil : 'paginate.pager'
        end
      end
      html += "\n"
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

  end
end