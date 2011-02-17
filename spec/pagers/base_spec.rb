require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Pagers::Base do
  let(:collection) { (1..12).to_a.paginate :page => 5 }
  let(:options) { { :test => 1, :sowas => 2 } }
  subject { RailsPaginate::Pagers::Base.new collection, options }
  specify { should respond_to :visible_pages }

  it "#visible_pages should raise StandardError" do
    lambda { subject.visible_pages }.should raise_error(StandardError)
  end

  it "#options should same as given options" do
    subject.options.should eq options
  end

  it "#collection should same as given collection" do
    subject.collection.should eq collection
  end

end