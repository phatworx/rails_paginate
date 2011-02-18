require 'active_support/all'

# nice rails paginate plugin
module RailsPaginate
  autoload :Renderers, 'rails_paginate/renderers'
  autoload :Collection, 'rails_paginate/collection'
  autoload :Helpers, 'rails_paginate/helpers'
  autoload :Pagers, 'rails_paginate/pagers'

  # page_param
  mattr_accessor :page_param
  @@page_param = :page

  # per_page
  mattr_accessor :per_page
  @@per_page = 20

  # default_renderer
  mattr_accessor :default_renderer
  @@default_renderer = :html_default

  # default_pager
  mattr_accessor :default_pager
  @@default_pager = :slider

  class << self
    # to configure rails_paginate
    # for a sample look the readme.rdoc file
    def setup
      yield self
    end

    # return renderer
    def renderer(renderer)
      raise ArgumentError, "renderer #{renderer} is not valid" unless (renderer.is_a? Symbol or renderer.is_a? String or renderer.is_a? Class)
      renderer = renderer.to_s if renderer.is_a? Symbol
      renderer = "rails_paginate/renderers/#{renderer}".camelize.constantize if renderer.is_a? String
      if block_given?
        yield renderer
      else
        renderer
      end
    end

    # return pager
    def pager(pager)
      raise ArgumentError, "pager #{pager} is not valid" unless (pager.is_a? Symbol or pager.is_a? String or pager.is_a? Class)
      pager = pager.to_s if pager.is_a? Symbol
      pager = "rails_paginate/pagers/#{pager}".camelize.constantize if pager.is_a? String
      if block_given?
        yield pager
      else
        pager
      end
    end

    # init rails paginate
    def init
      require 'rails_paginate/rails' if defined?(::Rails::Engine)
      ::Array.send(:include, Helpers::Array)
      ::ActiveRecord::Base.send(:extend, Helpers::ActiveRecord) if defined?(::ActiveRecord::Base)
      ::ActiveRecord::Relation.send(:include, Helpers::ActiveRecord) if defined?(::ActiveRecord::Relation)
      ::ActionView::Base.send(:include, Helpers::ActionView) if defined?(::ActionView::Base)
    end
  end
end

RailsPaginate.init