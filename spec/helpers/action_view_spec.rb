require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Helpers::ActionView do
  subject { ActionView::Base.new }
  specify { should respond_to :paginate }
end