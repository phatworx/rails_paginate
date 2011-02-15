require 'active_support/all'

# nice rails paginate plugin
module RailsPaginate
  autoload :Renderer, 'rails_paginate/renderer'
  autoload :Collection, 'rails_paginate/collection'

  # page_param
  mattr_accessor :page_param
  @@page_param = :page

  # per_page
  mattr_accessor :per_page
  @@per_page = 20

  # method: :jumping or :sliding
  mattr_accessor :method
  @@method = :sliding


  class << self
    # to configure rails_paginate
    # for a sample look the readme.rdoc file
    def setup
      yield self
    end

    # renderer
    def renderer(renderer = nil, &block)
      if renderer.nil?
        @renderer
      else
        renderer = renderer.to_s if renderer.is_a? Symbol
        if renderer.is_a? String
          renderer = "rails_paginate/renderer/#{renderer}".camelize.constantize
        end

        if block_given?
          @renderer = renderer.new &block
        else
          @renderer = renderer.new
        end
      end
    end

    def init
      require 'rails_paginate/core_ext/array'

      # set default method
      renderer :html_default
    end
  end
end

RailsPaginate.init