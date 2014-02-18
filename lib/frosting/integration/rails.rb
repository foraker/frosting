require 'frosting/presentation'

module Frosting
  class Railtie < ::Rails::Railtie
    initializer 'frosting.presentation' do
      ActiveSupport.on_load(:action_controller) do
        define_method :present do |resource, options = {}|
          Repository.present(resource, { context: view_context }.merge(options))
        end

        define_method :present_collection do |resources, options = {}|
          Repository.present_collection(resources, { context: view_context }.merge(options))
        end
      end
    end
  end
end
