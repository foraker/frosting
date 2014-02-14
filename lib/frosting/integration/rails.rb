require 'frosting/presentation'

module Frosting
  class Railtie < ::Rails::Railtie
    initializer 'frosting.presentation' do
      ActiveSupport.on_load(:action_controller) do
        def present(resource)
          Repository.present(resource, view_context)
        end

        def present_collection(resources)
          Repository.present_collection(resources, view_context)
        end
      end
    end
  end
end
