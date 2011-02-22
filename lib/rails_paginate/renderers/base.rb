module RailsPaginate::Renderers
  # base method
  class Base
    attr_reader :view, :collection, :options, :pager

    # setup rails_paginate collection
    def initialize(view, collection, pager, options = {})
      raise ArgumentError, "first argument must be a RailsPaginate::Collection" unless collection.is_a? RailsPaginate::Collection
      raise ArgumentError, "second argument must be a Hash" unless options.is_a? Hash
      raise ArgumentError, "third argument must be an instance of RailsPaginate::Pagers::Base" unless pager.is_a? RailsPaginate::Pagers::Base
      @options = options
      @collection = collection
      @view = view
      @pager = pager
    end

    # build url
    def url_for_page(page)
      view.url_for(view.default_url_options.merge({page_param.to_sym => page}))
    end

    # abstrack renderer
    def render
      raise StandardError, "render is not implemented"
    end

    protected

    # link to page with i18n support
    def link_to_page(page, key, link_options = {})
      css_class = "#{link_options[:class]} #{page == current_page ? 'current' : ''}"
      if key.nil?
        content_tag :span, "..", :class => "spacer"
      elsif page.nil?
        content_tag :span, t(key), :class => "#{css_class} unavailable"
      else
        link_to t(key, :page => page), url_for_page(page), :class => css_class, :alt => view.strip_tags(t(key, :page => page)), :remote => options[:remote], :method => options[:method]
      end
    end

    #
    def page_param
      options[:page_param] || RailsPaginate.page_param
    end

    # helper
    def current_page
      collection.current_page
    end

    # map to view helper
    def content_tag(*args, &block)
      view.content_tag(*args, &block)
    end

    # map to view helper
    def link_to(*args, &block)
      view.link_to(*args, &block)
    end

    # map to view helper
    def t(*args)
      view.t(*args)
    end

  end
end