class Array
  def paginate(*args)
    options = args.extract_options!
    RailsPaginate::Collection.new(self, args.first || options[:page], options[:per_page])
  end
end