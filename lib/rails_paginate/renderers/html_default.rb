module RailsPaginate::Renderers
  # normale renderer
  class HtmlDefault < Base


    def render
      view.content_tag(:ul) do
        html = "\n"
        html += content_tag(:li, :class => "first_page") do
          link_to_page collection.first_page, 'paginate.first_page_label'
        end
        html += "\n"
        html += content_tag(:li, :class => "previous_page") do
          link_to_page collection.previous_page, 'paginate.previous_page_label'
        end

        html += render_pages

        html += "\n"
        html += content_tag(:li, :class => "next_page") do
          link_to_page collection.next_page, 'paginate.next_page_label'
        end
        html += "\n"
        html += content_tag(:li, :class => "last_page") do
          link_to_page collection.last_page, 'paginate.last_page_label'
        end
        html += "\n"
        html.html_safe
      end
    end

    def render_pages
      html = ""

      visible_pages.to_a.each do |page|
        html += "\n"
        html += view.content_tag(:li, :class => "pager") do
          link_to_page page, page.nil? ? nil : 'paginate.pager'
        end
      end
      html += "\n"
      html.html_safe
    end

  end
end