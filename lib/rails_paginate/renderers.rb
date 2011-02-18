module RailsPaginate
  # renderer modules
  module Renderers
    autoload :Base, 'rails_paginate/renderers/base'
    autoload :HtmlDefault, 'rails_paginate/renderers/html_default'
  end
end