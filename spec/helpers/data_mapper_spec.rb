require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Helpers::DataMapper do
  subject { DataMapperItem }
  specify { should respond_to :paginate }

  describe "return of #paginate" do
    subject { DataMapperItem.paginate }
    it { should be_a RailsPaginate::Collection }
  end
end