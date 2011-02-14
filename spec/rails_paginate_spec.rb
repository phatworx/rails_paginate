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
