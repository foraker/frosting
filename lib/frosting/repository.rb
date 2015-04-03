require "active_support/core_ext/string/inflections"
require "active_support/core_ext/module/delegation"

module Frosting
  class Repository
    def self.present(resource, options = {})
      begin
        klass = options[:presenter] || "Presenters::#{resource.class.name}".constantize
        klass.new(resource, options[:context])
      rescue LoadError
        raise "No such presenter: #{klass}"
      end
    end

    def self.present_collection(collection, options = {})
      PresentedCollection.new(collection, options)
    end
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
