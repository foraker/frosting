require File.expand_path("../../../lib/frosting/base_presenter", __FILE__)

module Frosting
  class AssociatedTestPresenter < BasePresenter; end

  class TestPresenter < BasePresenter
    presents_super :associated_test_1
    presents_super :associated_test_2, presenter: AssociatedTestPresenter
    presents_super :associated_collection, collection: true

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
    let(:context)          { double(root_url: "/home") }
    let(:associated_class) { double(name: "AssociatedTest") }
    let(:resource) do
      double(
        name: "bruce wayne",
        associated_test_1: double(class: associated_class),
        associated_test_2: double,
        associated_collection: [double(class: associated_class)]
      )
    end

    subject { described_class.new(resource, context) }

    before { stub_const('Presenters::AssociatedTest', AssociatedTestPresenter) }

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
      subject.associated_test_1.should be_a Presenters::AssociatedTest
    end

    it "correctly accepts presentation options with `presents_super`" do
      subject.associated_test_2.should be_a AssociatedTestPresenter
    end

    it "presents a collection of resources with `presents_super`" do
      subject.associated_collection.first.should be_a Presenters::AssociatedTest
    end
  end
end
