module RailsPaginate
  # renderer modules
  module Renderer
    autoload :Base, 'rails_paginate/renderer/base'
    autoload :HtmlDefault, 'rails_paginate/renderer/html_default'
    autoload :HtmlList, 'rails_paginate/renderer/html_list'
  end
end