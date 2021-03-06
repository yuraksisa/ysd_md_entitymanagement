require 'data_mapper' unless defined?DataMapper
require 'ysd-plugins_aspect_configuration' unless defined?Plugins::AspectConfiguration

module Model
  #
  # Represents the aspects that have been set up for the entity
  #
  class EntityAspect
    include DataMapper::Resource
    include Plugins::AspectConfiguration
    
    storage_names[:default] = 'plugins_model_aspects'
    
    property :model, String, :field => 'model', :length => 32, :key => true
    property :aspect, String, :field => 'aspect', :length => 32, :key => true
    
    #
    # Gets the variable name which stores the param value for the entity/aspect
    #
    def get_variable_name(attribute_id)
     
      "aspect.#{aspect}.#{model}.#{attribute_id}"
     
    end
    
    #
    # Gets the module name
    #
    def get_module_name
    
      return :entity_management
    
    end
        
  end #EntityAspect
end #Model