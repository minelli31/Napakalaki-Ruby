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
             new(t,0,0,0,Array.new,Array.new,death)
         end
        
        def get_bad_levels
          return @levels
        end
        
         def isEmpty
             empty = false

             if(@levels == 0 and @nVisibleTreasures <= 0 and 
                 @nHiddenTreasures <= 0 and (@specificVisibleTreasures == nil or @specificVisibleTreasures.empty?) and
                 (@specificHiddenTreasures == nil or @specificHiddenTreasures.empty?) and @death == false)
                     empty = true
             end

             return empty

         end   
        
         def to_s
             "Text = #{@text} \nLost levels = #{@levels} "
         end
        
         def adjustToFitTreasureLists(v,h)
             puts "Entra en adjustToFitTreasureLists"
             puts "@specificHiddenTreasures -> " + @specificHiddenTreasures.to_s()
             puts "@specificHiddenTreasures -> " + @specificHiddenTreasures.to_s()
             bc = BadConsequence.new_bad_consequence_number("",0,0,0)
             if @nVisibleTreasures != 0 or @nHiddenTreasures != 0 
                 if (@nVisibleTreasures >= v.size)
                     nV = v.size
                 else
                     nV = @nVisibleTreasures
                 end
                
                 if (@nHiddenTreasures >= h.size)
                     nH = h.size
                 else
                     nH = @nHiddenTreasures
                 end
                 bc = BadConsequence.new_bad_consequence_number(@text,@levels,nV,nH)
                
             elsif @specificHiddenTreasures.empty? or @specificVisibleTreasures.empty?
                 sV = Array.new
                 sH = Array.new
                
                 v.each { |t| 
                     sV << t.type                   
                 }
                 intersectionV = sV & @specificVisibleTreasures
                
                 h.each { |t| 
                         sH << t.type                   
                 }
                 intersectionH = sH & @specificHiddenTreasures
                 puts "intersectionV -> " + intersectionV.to_s()
                 puts "intersectionH -> " + intersectionH.to_s()
                 bc = BadConsequence.new_bad_consequence_specific(@text,@levels,intersectionV,intersectionH)               
             end
            
             return bc
         end
        
         def substractVisibleTreasure(t)
             if @nVisibleTreasures != 0
               @nVisibleTreasures = @nVisibleTreasures - 1
 
             elsif !@specificVisibleTreasures.empty? or @specificVisibleTreasures != nil
                 if @specificVisibleTreasures.include?(t.type)
                     @specificVisibleTreasures.delete(t.type)
                 end
             end
         end

         def substractHiddenTreasure(t)
             if @nHiddenTreasures != 0
                 @nHiddenTreasures = @nHiddenTreasures - 1

             elsif (!@specificHiddenTreasures.empty? or @specificHiddenTreasures != nil)
                 if (@specificHiddenTreasures.include?(t.type))
                     @specificHiddenTreasures.delete(t.type)
                 end
             end
         end 
  end
end

