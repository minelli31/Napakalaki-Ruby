# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.
module Napakalaki
    class DeathBadConsequence < NumericBadConsequence

        attr_accessor :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :death

        def initialize(t,l,nVisible,nHidden,death)
            super(t,l,nVisible,nHidden)
            @death = death
        end

        private_class_method :new

        def self.new_bad_consequence_death(t,death)
            new(t,0,0,0,Array.new,Array.new,death)
        end
        
        def isEmpty
            empty = false

            if(@death == false)
                empty = true
            end

            return empty
        end 
    end
end
