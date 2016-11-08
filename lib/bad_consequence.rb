# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Napakalaki
  class BadConsequence
    
    attr_accessor :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :specificHiddenTreasures, :specificVisibleTreasures, :death
    
    def initialize(text, levels = 0, n_visible_treasures = 0, n_hidden_treasures = 0, specific_visible_treasures = Array.new, specific_hidden_treasures = Array.new, death = false) 
      @text = text
      @levels = levels 
      @nVisibleTreasures = n_visible_treasures
      @nHiddenTreasures = n_hidden_treasures
      @specificVisibleTreasures = specific_visible_treasures
      @specificHiddenTreasures = specific_hidden_treasures
      @death = death
    end
    

        # "Sobrecarga" del constructor. Como en ruby solo existe un consructor
        # tenemos que llamar al método new, haciendo primero una llamada a self
        # el método new debe ser privado

        private_class_method :new

        def self.new_bad_consequence_number(t,l,nVisible,nHidden)
            new(t,l,nVisible,nHidden,Array.new,Array.new,false)
        end

        def self.new_bad_consequence_specific(t,l,v,h)
            new(t,l,0,0,v,h,false)
        end

        def self.new_bad_consequence_death(t,death)
            new(t,nil,0,0,Array.new,Array.new,death)
        end
        
        def get_bad_levels
          return @levels
        end
                
        def to_s
            "Text = #{@text} \nLost levels = #{@levels} \nNumber of visible treasures = #{@nVisibleTreasures} \nNumber of hidden treasures = #{@nHiddenTreasures}"
        end
    
  end
end

