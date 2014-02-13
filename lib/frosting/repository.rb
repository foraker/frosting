require "active_support/core_ext/string/inflections"

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
      collection.map { |resource| present(resource, options) }
    end
  end
end
