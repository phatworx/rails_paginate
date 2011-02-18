require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Renderers::HtmlDefault do


  context "empty collection" do
    let(:collection) { [].paginate }
    context "pager type slider" do
      subject { RailsPaginate::Renderers::HtmlDefault.new action_view, collection, RailsPaginate.pager(:slider).new(collection) }
      specify { should respond_to :render }
      it "#render should not raise StandardError" do
        lambda { subject.render }.should_not raise_error(StandardError)
      end
    end
  end

  context "collection with 100 items" do
    let(:collection) { (1..100).to_a.paginate }
    context "pager type slider" do
      before { @renderer = RailsPaginate::Renderers::HtmlDefault.new action_view, collection, RailsPaginate.pager(:slider).new(collection) }
      subject { @renderer }
      specify { should respond_to :render }
      it "#render should not raise StandardError" do
        lambda { subject.render }.should_not raise_error(StandardError)
      end

      context "result of #render" do
        subject { @renderer.render }
        specify { should be_an String }

        it("should not have the div at first") { subject.should_not have_tag('> div', :count => 1) }
        it("should have one ul") { subject.should have_tag('ul') }
        it("should have one li") { subject.should have_tag('ul > li', :count => 9) }
        [:first_page, :previous_page, :first_pager, :last_pager, :next_page, :last_page].each do |class_attr|
          it("should have one li.#{class_attr}") { subject.should have_tag("ul > li.#{class_attr}", :count => 1) }
        end
        it("should have 5 li.pager") { subject.should have_tag('ul > li.pager', :count => 5) }
        it("should have 8 ul > li > a") { subject.should have_tag('ul > li > a', :count => 8) }
      end


    end
  end

end