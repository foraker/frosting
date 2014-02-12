require 'rails'
require 'action_controller/railtie' # allows ActionController::Base
require 'rspec/rails'
require File.expand_path("../../lib/frosting/presentation", __FILE__)

module TestRailsApp
  class Application < Rails::Application
    config.secret_key_base = 'frosting-is-sweet'
  end
  class ApplicationController < ActionController::Base
    include Frosting::Presentation
  end
end

describe 'The most helpful controller methods since current_user', type: :controller do
  class FakeResource; end
  class FakeResourceTwo; end

  module Presenters
    class FakeResource < Struct.new(:resource, :context); end
    class FakeResourceTwo < Struct.new(:resource, :context); end
  end

  controller(TestRailsApp::ApplicationController) do
  end

  describe "#present" do
    let(:instance) { FakeResource.new }

    subject { controller.send(:present, instance) }

    it             { should be_instance_of(Presenters::FakeResource) }
    its(:resource) { should == instance }
    its(:context)  { should be_instance_of controller.view_context_class }

    it "throws an error when the resource has no presenter" do
      class OtherFakeResource; end
      expect {
        controller.send(:present, OtherFakeResource.new)
      }.to raise_error
    end
  end

  describe '#present_collection' do
    it 'presents each member of the collection appropriately' do
      collection = [FakeResource.new, FakeResourceTwo.new]

      presenters = controller.send(:present_collection, collection)
      expect(presenters.map(&:class)).to eq [Presenters::FakeResource, Presenters::FakeResourceTwo]
    end
  end
end
