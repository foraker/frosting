require File.expand_path("../../../lib/frosting/base_presenter", __FILE__)

module Frosting
  class AssociatedTestPresenter < BasePresenter; end

  class TestPresenter < BasePresenter
    presents_super :associated_test, options: {
      presenter: AssociatedTestPresenter
    }

    def page_title
      "Page Title"
    end

    def formatted_name
      name.upcase
    end

    def root_url
      h.root_url
    end
  end

  describe TestPresenter do
    let(:context)  { double(root_url: "/home") }
    let(:resource) { double(name: "bruce wayne", associated_test: double) }

    subject { described_class.new(resource, context) }

    it "responds to defined methods" do
      subject.page_title.should == "Page Title"
    end

    it "delegates undefined methods" do
      subject.formatted_name.should == "BRUCE WAYNE"
    end

    it "delegates to the context" do
      subject.root_url.should == "/home"
    end

    it "presents result of resource methods with `presents_super`" do
      subject.associated_test.should be_a AssociatedTestPresenter
    end
  end
end
