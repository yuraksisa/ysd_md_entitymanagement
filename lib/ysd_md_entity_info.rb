module Model

  #
  # Defines a entity. An entity can be extended using aspects
  #
  class EntityInfo
    
    attr_reader :id, :description, :model_class
    
    @@entities = {}
    
    #
    # Constructor
    #
    # @param [String] id
    #  The entity description
    # 
    # @param [String] description
    #  The entity description
    #
    #
    def initialize(id, description, model_class)
      @id = id
      @description = description
      @model_class = model_class

      self.class.entities[id.to_sym] = self
      
    end
      
    #
    # Get an entity info instance from its id
    #  
    def self.get(id)
     
     return entities[id.to_sym]
                           
    end  
      
    #
    # Get the aspects which can be configured for the entity
    #    
    # @return [Array] array of ::Plugins::Aspect
    #
    def get_aspects(context)
    
      aspects_ids = aspects.map { |ent_aspect| ent_aspect.aspect.to_sym }
            
      aspects = Plugins::Plugin.plugin_invoke_all('aspects', context).select do |aspect|
        aspects_ids.include?(aspect.id)
      end
      
      return aspects  
   
    end
    
    #
    # Get the entity aspects
    #
    # @return [Array] array of Model::EntityAspect
    #
    def entity_aspects
      
      aspects
      
    end
    
    #
    # Get the entity aspect associated to the entity
    #
    # @return [EntityAspect]
    #
    def entity_aspect(aspect)
      
      (aspects.select { |entity_aspect| entity_aspect = aspect.to_sym }).first
      
    end
    
    #
    # Get a json representation of the 
    #
    def to_json(*args)
      
      {:id => id, :description => description, :aspects => aspects}.to_json
      
    end
    
    #
    # Assign aspects to the entity
    #
    def assign_aspects(assigned_aspects)
        
        the_assigned_aspects = assigned_aspects.map { |entity_aspect| entity_aspect['aspect']  }
        
        remove_aspects = EntityAspect.all(:entity_info => id, 
                                          :aspect.not => the_assigned_aspects )
         
        # remove not existing aspects
        if remove_aspects
          remove_aspects.destroy      
        end
        
        # add new aspects
        assigned_aspects.each do |entity_aspect|
          if not EntityAspect.get(entity_aspect['aspect'], entity_aspect['entity'])
            EntityAspect.create(entity_aspect)
          end
        end
            
        @aspects = EntityAspect.all(:entity_info => id)
    
    end    
    
    private
    
    #
    # Retrieve the aspects
    #
    def aspects
      
      if not @aspects
        @aspects = EntityAspect.all(:entity_info => id)
      end
      
      @aspects
      
    end
    
    #
    # Retrieve the entities
    #
    def self.entities
      
      return @@entities
    
    end
    
  end #EntityInfo
end #Model