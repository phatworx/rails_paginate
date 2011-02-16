require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Renderers::HtmlDefault do
  let(:collection) { [].paginate }
  subject { RailsPaginate::Renderers::HtmlDefault.new collection }
  specify { should respond_to :render }

  it "#render should not raise StandardError" do
    lambda { subject.render }.should_not raise_error(StandardError)
  end

end