require 'delegate'
require 'frosting/presentation'

module Frosting
  class BasePresenter < SimpleDelegator
    include Presentation

    def self.presents_super(*methods, options: {})
      methods.each do |method|
        define_method(method) do
          present super(), options.merge(context: @context)
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
