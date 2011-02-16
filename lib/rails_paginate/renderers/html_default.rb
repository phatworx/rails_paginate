module RailsPaginate::Renderers
  # normale renderer
  class HtmlDefault < Base
    def render
      view.content_tag(:ul) do
        html = ""
        html += view.content_tag(:li) do
          view.link_to "First page", collection.first_page.to_s
        end
        html += view.content_tag(:li) do
          view.link_to_unless collection.previous_page.nil?, "Previous page", collection.previous_page.to_s
        end
        html += view.content_tag(:li) do
          view.link_to_unless collection.next_page.nil?, "Next page", collection.next_page.to_s
        end
        html += view.content_tag(:li) do
          view.link_to "Last page", collection.first_page.to_s
        end
        html.html_safe
      end
    end
  end
end