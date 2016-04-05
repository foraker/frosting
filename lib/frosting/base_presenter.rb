require 'delegate'
require 'frosting/presentation'

module Frosting
  class BasePresenter < SimpleDelegator
    include Presentation

    def self.presents_super(*arguments)
      options = arguments.last.is_a?(Hash) ? arguments.pop : {}
      present_method = options.delete(:collection) ? :present_collection : :present

      arguments.each do |method|
        define_method(method) do
          send(present_method, super(), options.merge(context: @context))
        end
      end
    end

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
