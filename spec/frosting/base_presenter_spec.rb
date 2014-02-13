require File.expand_path("../../../lib/frosting/base_presenter", __FILE__)

module Frosting
  class TestPresenter < BasePresenter
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
    let(:resource) { double(name: "bruce wayne") }

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
  end
end