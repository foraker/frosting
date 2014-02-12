require "delegate"

module Frosting
  class BasePresenter < SimpleDelegator
    def initialize(resource, context = nil)
      @context = context
      @wrapped = resource
      super(@wrapped)
    end

    private

    def _context
      @context
    end

    alias :view_context :_context
    alias :h :_context
  end
end
