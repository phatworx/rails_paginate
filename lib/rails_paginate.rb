require 'active_support/all'

# nice rails paginate plugin
module RailsPaginate
  autoload :Method, 'rails_paginate/method'
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

    def method(method = nil, &block)
      if method.nil?
        @method
      else
        method = method.to_s if method.is_a? Symbol

        if method.is_a? String
          method.gsub!(/^[a-z]|\s+[a-z]/) { |a| a.upcase }
          method = "RailsPaginate::Method::#{method}".constantize
        end

        @method = method.new &block
      end
    end

    def init
      require 'rails_paginate/core_ext/array'

      # set default method
      # method :sliding
    end
  end
end

RailsPaginate.init