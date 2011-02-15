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
  subject { @array }
  specify { should respond_to :paginate }

  describe :paginate, "first page" do
    subject { @array.paginate 1 }
    specify { should be_a RailsPaginate::Collection }
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
    its(:count) { should eq 10 }
    its(:pages) { should eq 20 }
    its(:total) { should eq 199 }
    its(:offset) { should eq 0 }
    its(:current_results) { should eq 10 }
    its(:next_page) { should eq 2 }
    its(:previous_page) { should be_nil }
    its(:need_paginate?) { should be_true }
    its(:first_page?) { should be_true }
    its(:last_page?) { should be_false }
  end

  context "without per_page on page 10" do
    before(:all) { @collection = @array.paginate :page => 10 }
    subject { @collection }
    its(:count) { should eq 10 }
    its(:pages) { should eq 20 }
    its(:total) { should eq 199 }
    its(:offset) { should eq 90 }
    its(:current_results) { should eq 10 }
    its(:next_page) { should eq 11 }
    its(:previous_page) { should eq 9 }
    its(:need_paginate?) { should be_true }
    its(:first_page?) { should be_false }
    its(:last_page?) { should be_false }
  end

  context "without per_page on last page" do
    before(:all) { @collection = @array.paginate :page => 20 }
    subject { @collection }
    its(:count) { should eq 9 }
    its(:pages) { should eq 20 }
    its(:total) { should eq 199 }
    its(:offset) { should eq 190 }
    its(:current_results) { should eq 9 }
    its(:next_page) { should be_nil }
    its(:previous_page) { should eq 19 }
    its(:need_paginate?) { should be_true }
    its(:first_page?) { should be_false }
    its(:last_page?) { should be_true }
  end

end
