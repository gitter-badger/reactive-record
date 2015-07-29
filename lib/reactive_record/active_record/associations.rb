module ActiveRecord
  
  class Base
    
    def self.reflect_on_all_associations
      base_class.instance_eval { @associations ||= [] }
    end
    
    def self.reflect_on_association(attribute)
      reflect_on_all_associations.detect { |association| association.attribute == attribute }
    end
  
  end
  
  module Associations
    
    class AssociationReflection
      
      attr_reader :association_foreign_key
      attr_reader :attribute
      attr_reader :macro
            
      def initialize(owner_class, macro, name, options = {})
        owner_class.reflect_on_all_associations << self
        @owner_class = owner_class
        @macro =       macro
        @klass_name =  options[:class_name] || (collection? && name.camelize.gsub(/s$/,"")) || name.camelize
        @association_foreign_key = options[:foreign_key] || (macro == :belongs_to && "#{name}_id") || "#{@owner_class.name.underscore}_id"
        @attribute =   name
      end
      
      def inverse_of
        @inverse_of ||= klass.reflect_on_all_associations.detect { | association | association.association_foreign_key == @association_foreign_key }.attribute
      end
      
      def klass
        @klass ||= Object.const_get(@klass_name)
      end
      
      def collection?
        [:has_many].include? @macro
      end
      
    end
    
  end
  
  
end