# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.

# def self.checkPings
  ## A static method
# end
module Napakalaki 
    class BadConsequenceFactory
        
        #private_class_method :new
        
        def self.create(t,l,nVisible,nHidden)
            return NumericBadConsequence.new_bad_consequence_number(t,l,nVisible,nHidden)
        end
        
        def self.create(t, l, v, h)
            return SpecificBadConsequence.new_bad_consequence_specific(t,l,v,h)
        end
        
        def self.create(t,death)
            return DeathBadConsequence.new_bad_consequence_death(t,death)
        end
    end
end
