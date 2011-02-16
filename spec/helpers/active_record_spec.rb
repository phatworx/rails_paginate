require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Helpers::ActiveRecord do
  subject { Item }
  specify { should respond_to :paginate }
  
  describe "return of #paginate" do
    subject { Item.paginate }
    it { should be_a RailsPaginate::Collection }
  end
end