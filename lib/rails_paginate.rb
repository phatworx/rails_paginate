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

    # getter and setter for renderer configuration
    def renderer(renderer = nil, &block)
      if renderer.nil?
        @renderer
      else
        renderer = renderer.to_s if renderer.is_a? Symbol
        if renderer.is_a? String
          renderer = "rails_paginate/renderers/#{renderer}".camelize.constantize
        end

        if block_given?
          @renderer = renderer.new &block
        else
          @renderer = renderer.new
        end
      end
    end

    # init rails paginate
    def init
      ::Array.send(:include, Helpers::Array)
      ::ActiveRecord::Base.send(:extend, Helpers::ActiveRecord)# if defined? ::ActiveRecord

      #require 'rails_paginate/core_ext/active_record'
      #require 'rails_paginate/core_ext/array'

      #::ActiveSupport.on_load(:active_record) do
      #  include DeviseSecurityExtension::Controllers::Helpers
      #end

      # set default method
      renderer :html_default
    end
  end
end

RailsPaginate.init