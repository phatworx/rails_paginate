require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Helpers::ActionView do
  context "ActionView::Base.new" do
    let(:action_view) { ActionView::Base.new }
    let(:collection) { (1..55).to_a.paginate }
    subject { action_view }
    specify { should respond_to :paginate }

    it "#paginate should raise an error when no collection given" do
      lambda { subject.paginate }.should raise_error(ArgumentError)
    end

    [
        {:items => 100, :page => 1, :per_page => 15},
        {:items => 300, :page => 2, :per_page => 50},
        {:items => 11, :page => 5, :per_page => 15},
        {:items => 0, :page => 1, :per_page => 15},
        {:items => 12, :page => 1, :per_page => 15}
    ].each do |config|
      context "#paginate an Array with #{config[:items]} items, page #{config[:page]}, per_page #{config[:per_page]}" do
        before do
          @collection = (1..config[:items]).to_a.paginate :page => config[:page], :per_page => config[:per_page]
          @pagination = action_view.paginate @collection
        end
        subject { @pagination }
        it("return should be a kind of String") { should be_a String }
      end
    end

    context "#paginate with class => dummy" do
      before { @pagination = action_view.paginate collection, :class => "dummy" }
      subject { @pagination }

      it { subject.should match(/^<div class="pagination dummy">(.*)<\/div>$/) }
    end

  end
end