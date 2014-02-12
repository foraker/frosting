require File.expand_path("../../../lib/frosting/presentation", __FILE__)

module Frosting
  class TestClass
    include Frosting::Presentation
  end

  describe "an instance a Presentation class" do

    subject { TestClass.new }

    describe "#present" do
      it "delegates to the Presenter repository and returns the presented resource" do
        resource, presented_resource = double, double
        Frosting::Repository.stub(:present)
          .with(resource)
          .and_return(presented_resource)

        subject.present(resource).should == presented_resource
      end
    end

    describe "#present_collection" do
      it "delegates to the Presenter repository and returns the presented collection" do
        collection, presented_collection = collection, double
        Frosting::Repository.stub(:present_collection)
          .with(collection)
          .and_return(presented_collection)

        subject.present_collection(collection).should == presented_collection
      end
    end
  end
end