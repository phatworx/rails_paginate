module RailsPaginate
  # method modules
  class Collection < Array
    attr_reader :current_page, :per_page, :total, :pages

    # initialize collection
    def initialize(results, page, total, per_page)
      # validate
      raise ArgumentError, "total is not valid" if total <= 0
      raise ArgumentError, "per_page is not valid" if per_page <= 0
      raise ArgumentError, "result is not an array" unless results.is_a? Array

      # replace
      replace(results)

      # save meta data
      @per_page = per_page.to_i
      @total    = total.to_i
      @pages    = (total / per_page.to_f).ceil

      # jump to correct page
      page = page.to_i if page.is_a? String
      page = first_page unless page.is_a? Fixnum
      page = first_page unless page > 0
      page = last_page unless page > pages

      # save page
      @current_page = page.to_i
    end

    # current page out of range
    def out_of_range?
      current_page > pages
    end

    # get offset
    def offset
      (current_page - 1) * per_page
    end

    # need paginate
    def need_paginate?
      total > per_page
    end

    # return count of current page
    def current_results
      if last_page?
        total % per_page
      else
        per_page
      end
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