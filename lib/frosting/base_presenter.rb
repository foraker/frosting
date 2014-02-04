module Frosting
  class BasePresenter < SimpleDelegator
    delegate :link_to, :content_tag, to: :@context

    def initialize(resource, context = nil)
      @context = context
      @wrapped = resource
      super(@wrapped)
    end
  end
end
