require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RailsPaginate do
  describe :setup, "to configure" do
    RailsPaginate.setup do |setup|
      subject { setup }

      describe :per_page, "set to 15" do
        before { subject.per_page = 15 }
        its(:per_page) { should be 15 }
      end

      describe :page_param, "set to :p" do
        before { subject.page_param = :p }
        its(:page_param) { should be :p }
      end

      describe :renderer, "set to :html_default" do
        before { subject.renderer :html_default }
        its(:renderer) { should be_a RailsPaginate::Renderer::HtmlDefault }
      end

      describe :renderer, "set to :html_list" do
        before { subject.renderer :html_list }
        its(:renderer) { should be_a RailsPaginate::Renderer::HtmlList }
      end

    end
  end
end

describe RailsPaginate::Collection do
  before :all do
    RailsPaginate.setup do |setup|
      setup.per_page = 10
    end
  end

  describe Array, "with 199 items" do
    before(:all) { @array = (1..199).to_a }
    subject { @array }
    specify { should respond_to :paginate }

    describe "return of #paginate" do
      subject { @array.paginate 1 }
      it { should be_a RailsPaginate::Collection }
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

  describe Array, "with 6 items" do
    before(:all) { @array = (1..6).to_a }
    context "without per_page on last page" do
      before(:all) { @collection = @array.paginate :page => 1 }
      subject { @collection }
      its(:count) { should eq 6 }
      its(:pages) { should eq 1 }
      its(:total) { should eq 6 }
      its(:offset) { should eq 0 }
      its(:current_results) { should eq 6 }
      its(:next_page) { should be_nil }
      its(:previous_page) { should be_nil }
      its(:need_paginate?) { should be_false }
      its(:first_page?) { should be_true }
      its(:last_page?) { should be_true }
    end
  end


end
