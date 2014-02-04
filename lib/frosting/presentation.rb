module Frosting
  module Presentation
    def present(resource, options = {})
      begin
        klass = options[:presenter] || "Presenters::#{resource.class.name}".constantize
        klass.new(resource, view_context)
      rescue LoadError
        raise "No such presenter: #{klass}"
      end
    end

    def present_collection(collection, options = {})
      collection.map { |resource| present(resource, options) }
    end
  end
end
