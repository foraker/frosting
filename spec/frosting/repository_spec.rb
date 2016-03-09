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

      context "specifying a presenter class via proc" do
        subject do
          described_class.present(resource, {
            context:   context,
            presenter: ->(resource) { Presenters::Test::Alternative }
          })
        end

        it { should be_instance_of(Presenters::Test::Alternative) }
        its(:resource) { should eq resource }
        its(:context)  { should eq context }
      end

      it "throws an exception when the resource has no presenter" do
        class Test::OtherResource ; end
        resource = Test::OtherResource.new
        expect {
          described_class.present(resource, context: context)
        }.to raise_error(
          Frosting::Repository::PresenterMissingError,
          "No such presenter: Presenters::Test::OtherResource"
        )
      end
    end

    describe ".present_collection" do
      class Collection < Array
        def test_method
          "cats"
        end
      end

      let(:resource) { double }
      let(:presented_resource) { double }
      let(:presented_collection) do
        described_class.present_collection(Collection.new.push(resource), {option: :val})
      end

      before do
        allow(described_class).to receive(:present)
          .with(resource, {option: :val})
          .and_return(presented_resource)
      end

      it "presents each item in the collection with options" do
        expect(presented_collection.to_a).to eq [presented_resource]
      end

      it "still acts like the original collection" do
        expect(presented_collection.test_method).to eq "cats"
      end

      it "allows addition of presented collections" do
        expect((presented_collection + presented_collection).to_a).
          to eq [presented_resource, presented_resource]
      end
    end
  end
end
