module RailsPaginate
  # method modules
  class Collection < Array
    attr_reader :current_page, :per_page, :pages, :array_or_relation

    # initialize collection
    def initialize(array_or_relation, page = nil, per_page = nil)
      # validate
      raise ArgumentError, "per_page is not valid" if not per_page.nil? and per_page <= 0 
      raise ArgumentError, "result is not an array or relation" unless array_or_relation.respond_to? :count

      # array_or_relation
      @array_or_relation = array_or_relation

      # save meta data
      @per_page          = per_page || RailsPaginate.per_page

      # load page with result
      load_page(page) unless page.nil?
    end

    # switch page
    def load_page(page)
      # jump to correct page
      page = page.to_i if page.is_a? String
      page = first_page unless page.is_a? Fixnum
      page = first_page unless page > 0
      page = last_page if page > pages

      # save page
      @current_page = page

      # load result
      load_result
    end

    # load result from input array_or_relation to internal array
    def load_result
      if array_or_relation.is_a? Array
        result = array_or_relation[offset..(offset + per_page - 1)]
      else
        result = array_or_relation.limit(per_page).offset(offset).all
      end

      self.replace result.nil? ? [] : result
    end

    def total
      @total ||= array_or_relation.count
    end

    def pages
      @pages ||= total == 0 ? 1 : (total / per_page.to_f).ceil
    end

    # get offset
    def offset
      (current_page - 1) * per_page
    end

    # need paginate
    def need_paginate?
      total > per_page
    end

    # return first page
    def first_page
      1
    end

    # return last page
    def last_page
      pages
    end

    # is current page the last page?
    def last_page?
      current_page == last_page
    end

    # is current page the first page?
    def first_page?
      current_page == first_page
    end

    # return next page
    def next_page
      current_page < pages ? (current_page + 1) : nil
    end

    # return previous page
    def previous_page
      current_page > 1 ? (current_page - 1) : nil
    end
  end
end