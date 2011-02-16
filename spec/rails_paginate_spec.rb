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
    end
  end

  describe :renderer do
    context ":html_default" do
      before { @renderer = RailsPaginate.renderer :html_default }
      subject { @renderer }
      it { should be_a RailsPaginate::Renderers::HtmlDefault }
    end

    context ":html_list" do
      before { @renderer = RailsPaginate.renderer :html_list }
      subject { @renderer }
      it { should be_a RailsPaginate::Renderers::HtmlList }
    end
  end
end

describe RailsPaginate::Collection do
  before :all do
    RailsPaginate.setup do |setup|
      setup.per_page = 10
    end
  end

  describe Item, "with 561 items" do
    before(:all) do
      561.times { |x| Item.create! :dummy => "Item #{x}" }
    end
    subject { Item }
    specify { should respond_to :paginate }

    describe "return of #paginate" do
      subject { Item.paginate }
      it { should be_a RailsPaginate::Collection }
    end

    context "without any result" do
      before(:all) { @collection = Item.where(:dummy => "dasfindeterbestimmtnicht").paginate :page => 1 }
      subject { @collection }
      its(:count) { should eq 0 }
      its(:current_page) { should eq 1 }
      its(:pages) { should eq 1 }
      its(:total) { should eq 0 }
      its(:offset) { should eq 0 }
      its(:next_page) { should be_nil }
      its(:previous_page) { should be_nil }
      its(:need_paginate?) { should be_false }
      its(:first_page?) { should be_true }
      its(:last_page?) { should be_true }
    end

    context "without per_page on first page" do
      before(:all) { @collection = Item.paginate :page => 1 }
      subject { @collection }
      its(:count) { should eq 10 }
      its(:current_page) { should eq 1 }
      its(:pages) { should eq 57 }
      its(:total) { should eq 561 }
      its(:offset) { should eq 0 }
      its(:next_page) { should eq 2 }
      its(:previous_page) { should be_nil }
      its(:need_paginate?) { should be_true }
      its(:first_page?) { should be_true }
      its(:last_page?) { should be_false }
    end

    context "without per_page on page 10" do
      before(:all) { @collection = Item.paginate :page => 10 }
      subject { @collection }
      its(:count) { should eq 10 }
      its(:current_page) { should eq 10 }
      its(:pages) { should eq 57 }
      its(:total) { should eq 561 }
      its(:offset) { should eq 90 }
      its(:next_page) { should eq 11 }
      its(:previous_page) { should eq 9 }
      its(:need_paginate?) { should be_true }
      its(:first_page?) { should be_false }
      its(:last_page?) { should be_false }
    end

    context "without per_page on last page" do
      before(:all) { @collection = Item.paginate :page => 57 }
      subject { @collection }
      its(:count) { should eq 1 }
      its(:current_page) { should eq 57 }
      its(:pages) { should eq 57 }
      its(:total) { should eq 561 }
      its(:offset) { should eq 560 }
      its(:next_page) { should be_nil }
      its(:previous_page) { should eq 56 }
      its(:need_paginate?) { should be_true }
      its(:first_page?) { should be_false }
      its(:last_page?) { should be_true }
    end

    context "with per_page 60 on page 3" do
      before(:all) { @collection = Item.paginate :page => 3, :per_page => 60 }
      subject { @collection }
      its(:count) { should eq 60 }
      its(:current_page) { should eq 3 }
      its(:pages) { should eq 10 }
      its(:total) { should eq 561 }
      its(:offset) { should eq 120 }
      its(:next_page) { should eq 4 }
      its(:previous_page) { should eq 2 }
      its(:need_paginate?) { should be_true }
      its(:first_page?) { should be_false }
      its(:last_page?) { should be_false }
    end

  end

  describe Array, "with 0 items" do
    before(:all) { @array = [] }
    subject { @array }
    specify { should respond_to :paginate }

    describe "return of #paginate" do
      subject { @array.paginate }
      it { should be_a RailsPaginate::Collection }
    end

    context "without per_page on first page" do
      before(:all) { @collection = @array.paginate :page => 1 }
      subject { @collection }
      its(:count) { should eq 0 }
      its(:current_page) { should eq 1 }
      its(:pages) { should eq 1 }
      its(:total) { should eq 0 }
      its(:offset) { should eq 0 }
      its(:next_page) { should be_nil }
      its(:previous_page) { should be_nil }
      its(:need_paginate?) { should be_false }
      its(:first_page?) { should be_true }
      its(:last_page?) { should be_true }
    end
  end

  describe Array, "with 199 items" do
    before(:all) { @array = (1..199).to_a }
    subject { @array }
    specify { should respond_to :paginate }

    describe "return of #paginate" do
      subject { @array.paginate }
      it { should be_a RailsPaginate::Collection }
    end

    context "without per_page on first page" do
      before(:all) { @collection = @array.paginate :page => 1 }
      subject { @collection }
      its(:count) { should eq 10 }
      its(:current_page) { should eq 1 }
      its(:pages) { should eq 20 }
      its(:total) { should eq 199 }
      its(:offset) { should eq 0 }
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
      its(:current_page) { should eq 10 }
      its(:pages) { should eq 20 }
      its(:total) { should eq 199 }
      its(:offset) { should eq 90 }
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
      its(:current_page) { should eq 20 }
      its(:pages) { should eq 20 }
      its(:total) { should eq 199 }
      its(:offset) { should eq 190 }
      its(:next_page) { should be_nil }
      its(:previous_page) { should eq 19 }
      its(:need_paginate?) { should be_true }
      its(:first_page?) { should be_false }
      its(:last_page?) { should be_true }
    end

    context "with per_page 60 on page 3" do
      before(:all) { @collection = @array.paginate :page => 3, :per_page => 60 }
      subject { @collection }
      its(:count) { should eq 60 }
      its(:current_page) { should eq 3 }
      its(:pages) { should eq 4 }
      its(:total) { should eq 199 }
      its(:offset) { should eq 120 }
      its(:next_page) { should eq 4 }
      its(:previous_page) { should eq 2 }
      its(:need_paginate?) { should be_true }
      its(:first_page?) { should be_false }
      its(:last_page?) { should be_false }
    end

  end

  describe Array, "with 6 items" do
    before(:all) { @array = (1..6).to_a }
    context "without per_page on last page" do
      before(:all) { @collection = @array.paginate :page => 1 }
      subject { @collection }
      its(:count) { should eq 6 }
      its(:current_page) { should eq 1 }
      its(:pages) { should eq 1 }
      its(:total) { should eq 6 }
      its(:offset) { should eq 0 }
      its(:next_page) { should be_nil }
      its(:previous_page) { should be_nil }
      its(:need_paginate?) { should be_false }
      its(:first_page?) { should be_true }
      its(:last_page?) { should be_true }
    end
  end


end
