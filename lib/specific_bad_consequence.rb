# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.
module Napakalaki
    class SpecificBadConsequence < BadConsequence
        attr_accessor :text, :levels, :specificHiddenTreasures, :specificVisibleTreasures, :death

        def initialize(text, levels = 0, specific_visible_treasures = Array.new, specific_hidden_treasures = Array.new, death = false) 
          super(text,levels)
          @specificVisibleTreasures = specific_visible_treasures
          @specificHiddenTreasures = specific_hidden_treasures
          @death = death
        end
        private_class_method :new

       def self.new_bad_consequence_number(t,l,nVisible,nHidden)
           new(t,l,nVisible,nHidden,Array.new,Array.new,false)
       end

       def self.new_bad_consequence_specific(t,l,v,h)
           new(t,l,0,0,v,h,false)
       end
        private_class_method :new

        def self.new_bad_consequence_specific(t,l,v,h)
            new(t,l,v,h,false)
        end

        def isEmpty
                empty = false

                if((@specificVisibleTreasures == nil or @specificVisibleTreasures.empty?) and
                    (@specificHiddenTreasures == nil or @specificHiddenTreasures.empty?) and @death == false)
                        empty = true
                end
            return empty
        end  

        def adjustToFitTreasureLists(v,h)
            if @specificHiddenTreasures.empty? or @specificVisibleTreasures.empty?
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

                bc = BadConsequenceFactory.create(@text,@levels,intersectionV,intersectionH,false)               
            end

            return bc
        end

        def substractVisibleTreasure(t)
            if !@specificVisibleTreasures.empty? or @specificVisibleTreasures != nil
                if @specificVisibleTreasures.include?(t.type)
                    @specificVisibleTreasures.delete(t.type)
                end
            end
        end

        def substractHiddenTreasure(t)
            if (!@specificHiddenTreasures.empty? or @specificHiddenTreasures != nil)
                if (@specificHiddenTreasures.include?(t.type))
                    @specificHiddenTreasures.delete(t.type)
                end
            end
        end
    end
end
