require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Helpers::Array do
  subject { Array.new }
  specify { should respond_to :paginate }
  
  describe "return of #paginate" do
    subject { Array.new.paginate }
    it { should be_a RailsPaginate::Collection }
  end
end