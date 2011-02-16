require 'active_support/all'

# nice rails paginate plugin
module RailsPaginate
  autoload :Renderers, 'rails_paginate/renderers'
  autoload :Collection, 'rails_paginate/collection'
  autoload :Helpers, 'rails_paginate/helpers'

  # page_param
  mattr_accessor :page_param
  @@page_param = :page

  # per_page
  mattr_accessor :per_page
  @@per_page = 20

  class << self
    # to configure rails_paginate
    # for a sample look the readme.rdoc file
    def setup
      yield self
    end

    def renderer(renderer)
      raise ArgumentError, "renderer #{renderer} is not valid" unless (renderer.is_a? Symbol or renderer.is_a? String or renderer.is_a? Class)
      renderer = renderer.to_s if renderer.is_a? Symbol
      renderer = "rails_paginate/renderers/#{renderer}".camelize.constantize if renderer.is_a? String
      renderer.new
    end

    # init rails paginate
    def init
      ::Array.send(:include, Helpers::Array)
      ::ActiveRecord::Base.send(:extend, Helpers::ActiveRecord) if defined?(::ActiveRecord::Base)
      ::ActionView::Base.send(:include, Helpers::ActionView) if defined?(::ActionView::Base)


      # set default method
      renderer :html_default
    end
  end
end

RailsPaginate.init