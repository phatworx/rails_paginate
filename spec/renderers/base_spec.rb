require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Renderers::Base do
  let(:collection) { [].paginate }
  let(:action_view) { ActionView::Base.new }
  subject { RailsPaginate::Renderers::Base.new action_view, collection }
  specify { should respond_to :render }

  it "#render should raise StandardError" do
    lambda { subject.render }.should raise_error(StandardError)
  end

end