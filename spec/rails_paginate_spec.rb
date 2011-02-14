require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RailsPaginate do
  describe :setup do


    context "when configure" do
      RailsPaginate.setup do |setup|

        describe "set per_page" do
          before { setup.per_page = 15 }
          subject { setup.per_page }
          it { should be 15 }
        end

        describe "set page_param" do
          before { setup.page_param = :p }
          subject { setup.page_param }
          it { should be :p }
        end

      end

    end

  end
end

describe Array do
  before :all do
    @array = (1..10).to_a
  end
  describe :paginate do
    subject { @array.paginate 1 }
    it { should be_a RailsPaginate::Collection }
  end
end

describe RailsPaginate::Collection do
  before :all do
    @array = (1..199).to_a
    RailsPaginate.setup do |setup|
      setup.per_page = 10
    end
  end

  context "without per_page on first page" do
    before(:all) { @collection = @array.paginate :page => 1 }

    subject { @collection }
    specify { @collection.count.should == 10 }
    specify { @collection.pages.should == 20 }
    specify { @collection.total.should == 199 }
    specify { @collection.offset.should == 0 }
    specify { @collection.current_results.should == 10 }
    specify { @collection.next_page.should == 2 }
    specify { @collection.previous_page.should == nil }
    specify { @collection.need_paginate?.should == true }
    specify { @collection.out_of_range?.should == false }
    specify { @collection.first_page?.should be_true }
    specify { @collection.last_page?.should be_false }

  end

  context "without per_page on page 10" do
    before(:all) { @collection = @array.paginate :page => 10 }

    subject { @collection }
    specify { @collection.count.should == 10 }
    specify { @collection.pages.should == 20 }
    specify { @collection.total.should == 199 }
    specify { @collection.offset.should == 90 }
    specify { @collection.current_results.should == 10 }
    specify { @collection.next_page.should == 11 }
    specify { @collection.previous_page.should == 9 }
    specify { @collection.need_paginate?.should == true }
    specify { @collection.out_of_range?.should == false }
    specify { @collection.first_page?.should be_false }
    specify { @collection.last_page?.should be_false }

  end

  context "without per_page on last page" do
    before(:all) { @collection = @array.paginate :page => 20 }

    subject { @collection }
    specify { @collection.count.should == 9 }
    specify { @collection.pages.should == 20 }
    specify { @collection.total.should == 199 }
    specify { @collection.offset.should == 190 }
    specify { @collection.current_results.should == 9 }
    specify { @collection.next_page.should == nil }
    specify { @collection.previous_page.should == 19 }
    specify { @collection.need_paginate?.should == true }
    specify { @collection.out_of_range?.should == false }
    specify { @collection.first_page?.should be_false }
    specify { @collection.last_page?.should be_true }
    
  end

end
