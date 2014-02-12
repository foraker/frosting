require File.expand_path("../../../lib/frosting/repository", __FILE__)

module Test ; end
module Presenters ; module Test ; end end

module Frosting
  describe Repository do
    class Test::Resource ; end
    class Presenters::Test::Resource < Struct.new(:resource, :context) ; end

    describe ".present" do
      let(:resource) { Test::Resource.new }
      let(:context)  { double }

      subject do
        described_class.present(resource, context: context)
      end

      it { should be_instance_of(Presenters::Test::Resource) }
      its(:resource) { should eq resource }
      its(:context)  { should eq context }

      context "specifying a presenter class" do
        class Presenters::Test::Alternative < Struct.new(:resource, :context) ; end

        subject do
          described_class.present(resource, {
            context:   context,
            presenter: Presenters::Test::Alternative
          })
        end

        it { should be_instance_of(Presenters::Test::Alternative) }
        its(:resource) { should eq resource }
        its(:context)  { should eq context }
      end

      it "throws an exception when the resource has no presenter" do
        class Test::OtherResource ; end
        resource = Test::OtherResource.new
        expect { described_class.present(resource, context: context) }.to raise_error(NameError)
      end
    end

    describe ".present_collection" do
      it "presents each item in the collection with options" do
        resource = double
        described_class.should_receive(:present)
          .with(resource, {option: :val})
        described_class.present_collection([resource], {option: :val})
      end
    end
  end
end