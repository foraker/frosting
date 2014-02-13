require 'frosting/repository'

module Frosting
  module Presentation
    def present(*args)
      Repository.present(*args)
    end

    def present_collection(*args)
      Repository.present_collection(*args)
    end
  end
end
