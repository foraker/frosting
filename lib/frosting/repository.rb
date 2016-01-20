require "active_support/core_ext/string/inflections"
require "active_support/core_ext/module/delegation"

module Frosting
  class Repository
    class PresenterMissingError < StandardError; end

    def self.present(resource, options = {})
      klass = options.fetch(:presenter) { infer_presenter(resource) }
      klass = procify(klass).call(resource)
      klass.new(resource, options[:context])
    rescue LoadError, NameError
      raise PresenterMissingError.new("No such presenter: #{klass}")
    end

    def self.present_collection(collection, options = {})
      PresentedCollection.new(collection, options)
    end

    def self.infer_presenter(resource)
      "Presenters::#{resource.class.name}".constantize
    end
    private_class_method :infer_presenter

    def self.procify(arg)
      arg.respond_to?(:call) ? arg : proc { arg }
    end
    private_class_method :procify
  end

  class PresentedCollection < SimpleDelegator
    include Enumerable

    delegate :each, to: :presented_collection

    def initialize(collection, options)
      @options = options
      super(collection)
    end

    private

    def presented_collection
      __getobj__.map do |resource|
        Repository.present(resource, @options)
      end
    end
  end
end
