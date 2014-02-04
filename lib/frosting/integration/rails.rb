require 'frosting/presentation'

module Frosting
  class Railtie < ::Rails::Railtie
    initializer 'frosting.presentation' do
      ActiveSupport.on_load(:action_controller) do
        include Frosting::Presentation
      end
    end
  end
end
