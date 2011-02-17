require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RailsPaginate::Pagers::Slider do

  it "#new without collection should raise StandardError" do
    lambda { RailsPaginate::Pagers::Slider.new }.should raise_error(ArgumentError)
  end

  context "collection without items" do
    before { @array = [] }
    context "paginate page 1 with 10 per page" do
      before { @collection = @array.paginate :page => 1, :per_page => 10 }
      describe "pager with collection and inner 3 and outer 1" do
        before { @pager = RailsPaginate::Pagers::Slider.new(@collection, {:inner => 3, :outer => 1}) }
        describe "#visible_pages" do
          subject { @pager.visible_pages }
          it { should include 1 }
          it { should_not include 2 }
          it("#count should equal 1") { subject.count.should eq 1 }
        end
      end
    end
  end

  context "collection with 500 items" do
    before { @array = (1...500).to_a }
    context "paginate page 8 with 10 per page" do
      before { @collection = @array.paginate :page => 8, :per_page => 10 }
      describe "pager with collection and inner 3 and outer 1" do
        before { @pager = RailsPaginate::Pagers::Slider.new(@collection, {:inner => 3, :outer => 1}) }
        describe "#visible_pages" do
          subject { @pager.visible_pages }
          it { should include 1 }
          it { should_not include 2 }
          it { should include 5 }
          it { should include 6 }
          it { should include 7 }
          it { should include 8 }
          it { should include 9 }
          it { should include 10 }
          it { should include 11 }
          it { should_not include 12 }
          it { should_not include 49 }
          it { should include 50 }
          it("#count should equal 8") { subject.count.should eq 11 }
          it("#at(1) should be nil") { subject.at(1).should be_nil }
          it("#at(49) should be nil") { subject.at(49).should be_nil }
        end
      end
    end

    context "paginate page 2 with 50 per page" do
      before { @collection = @array.paginate :page => 2, :per_page => 50 }
      describe "pager with collection and inner 3 and outer 2" do
        before { @pager = RailsPaginate::Pagers::Slider.new(@collection, {:inner => 3, :outer => 2}) }
        describe "#visible_pages" do
          subject { @pager.visible_pages }
          it { should include 1 }
          it { should include 2 }
          it { should include 3 }
          it { should include 4 }
          it { should include 5 }
          it { should_not include 6 }
          it { should_not include 7 }
          it { should_not include 8 }
          it { should include 9 }
          it { should include 10 }
          it("#count should equal 8") { subject.count.should eq 8 }
          it("#at(5) should be nil") { subject.at(5).should be_nil }
        end
      end
    end

    context "paginate page 6 with 13 per page" do
      before { @collection = @array.paginate :page => 6, :per_page => 13 }
      describe "pager with collection and inner 4 and outer 0" do
        before { @pager = RailsPaginate::Pagers::Slider.new(@collection, {:inner => 4, :outer => 0}) }
        describe "#visible_pages" do
          subject { @pager.visible_pages }
          it { should_not include 1 }
          it { should include 2 }
          it { should include 3 }
          it { should include 4 }
          it { should include 5 }
          it { should include 6 }
          it { should include 7 }
          it { should include 8 }
          it { should include 9 }
          it { should include 10 }
          it { should_not include 11 }
          it("#count should equal 9") { subject.count.should eq 9 }
        end
      end
    end

    context "paginate page 6 with 12 per page" do
      before { @collection = @array.paginate :page => 6, :per_page => 12 }
      describe "pager with collection and inner 0 and outer 2" do
        before { @pager = RailsPaginate::Pagers::Slider.new(@collection, {:inner => 0, :outer => 2}) }
        describe "#visible_pages" do
          subject { @pager.visible_pages }
          it { should include 1 }
          it { should include 2 }
          it { should_not include 3 }
          it { should_not include 7 }
          it { should include 6 }
          it { should_not include 8 }
          it { should_not include 40 }
          it { should include 41 }
          it { should include 42 }
          it { should_not include 43 }
          it("#count should equal 7") { subject.count.should eq 7 }
          it("#at(2) should be nil") { subject.at(2).should be_nil }
          it("#at(40) should be nil") { subject.at(40).should be_nil }
        end
      end
    end

    context "paginate page 3 with 100 per page" do
      before { @collection = @array.paginate :page => 3, :per_page => 100 }
      describe "pager with collection and inner 0 and outer 0" do
        before { @pager = RailsPaginate::Pagers::Slider.new(@collection, {:inner => 0, :outer => 0}) }
        describe "#visible_pages" do
          subject { @pager.visible_pages }
          it { should_not include 1 }
          it { should_not include 2 }
          it { should include 3 }
          it { should_not include 4 }
          it { should_not include 5 }
          it("#count should equal 1") { subject.count.should eq 1 }
        end
      end
    end
  end
end
