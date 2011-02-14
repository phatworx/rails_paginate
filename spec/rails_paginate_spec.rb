require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RailsPaginate do
  describe :setup, "to configure" do

    

    RailsPaginate.setup do |setup|

      describe :per_page, "set to 15" do
        before { setup.per_page = 15 }
        context :per_page do
          subject { setup.per_page }
          it { should be 15 }
        end
      end

      describe :page_param, "set to :p" do
        before { setup.page_param = :p }
        context :page_param do
          subject { setup.page_param }
          it { should be :p }
        end
      end

    end
  end
end

describe Array, "with 234 items" do
  before(:all) { @array = (1..234).to_a }
  describe :paginate, "first page" do
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
    context "count" do
      specify { subject.count.should eq 10 }
    end

    context "pages" do
      specify { subject.pages.should eq 20 }
    end

    context "total" do
      specify { subject.total.should eq 199 }
    end

    context "offset" do
      specify { subject.offset.should eq 0 }
    end

    context "current_results" do
      specify { subject.current_results.should eq 10 }
    end

    context "next_page" do
      specify { subject.next_page.should eq 2 }
    end

    context "previous_page" do
      specify { subject.previous_page.should be_nil }
    end

    context "need_paginate?" do
      specify { subject.need_paginate?.should be_true }
    end

    context "out_of_range?" do
      specify { subject.out_of_range?.should be_false }
    end

    context "first_page?" do
      specify { subject.first_page?.should be_true }
    end

    context "last_page?" do
      specify { subject.last_page?.should be_false }
    end

  end

  context "without per_page on page 10" do
    before(:all) { @collection = @array.paginate :page => 10 }

    subject { @collection }

    context "count" do
      specify { subject.count.should eq 10 }
    end

    context "pages" do
      specify { subject.pages.should eq 20 }
    end

    context "total" do
      specify { subject.total.should eq 199 }
    end

    context "offset" do
      specify { subject.offset.should eq 90 }
    end

    context "current_results" do
      specify { subject.current_results.should eq 10 }
    end

    context "next_page" do
      specify { subject.next_page.should eq 11 }
    end

    context "previous_page" do
      specify { subject.previous_page.should eq 9 }
    end

    context "need_paginate?" do
      specify { subject.need_paginate?.should be_true }
    end

    context "out_of_range?" do
      specify { subject.out_of_range?.should be_false }
    end

    context "first_page?" do
      specify { subject.first_page?.should be_false }
    end

    context "last_page?" do
      specify { subject.last_page?.should be_false }
    end

  end

  context "without per_page on last page" do
    before(:all) { @collection = @array.paginate :page => 20 }

    subject { @collection }

    context "count" do
      specify { subject.count.should eq 9 }
    end

    context "pages" do
      specify { subject.pages.should eq 20 }
    end

    context "total" do
      specify { subject.total.should eq 199 }
    end

    context "offset" do
      specify { subject.offset.should eq 190 }
    end

    context "current_results" do
      specify { subject.current_results.should eq 9 }
    end

    context "next_page" do
      specify { subject.next_page.should be_nil }
    end

    context "previous_page" do
      specify { subject.previous_page.should eq 19 }
    end

    context "need_paginate?" do
      specify { subject.need_paginate?.should be_true }
    end

    context "out_of_range?" do
      specify { subject.out_of_range?.should be_false }
    end

    context "first_page?" do
      specify { subject.first_page?.should be_false }
    end

    context "last_page?" do
      specify { subject.last_page?.should be_true }
    end

  end

end
