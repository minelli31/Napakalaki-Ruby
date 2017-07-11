# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.
module Napakalaki
    class NumericBadConsequence < BadConsequence

        attr_accessor :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :death

        def initialize(t,l,nVisible,nHidden,death = false)
            super(t,l)
            @nVisibleTreasures = nVisible
            @nHiddenTreasures = nHidden
            @death = death
        end

        private_class_method :new

            def self.new_bad_consequence_number(t,l,nVisible,nHidden)
                new(t,l,nVisible,nHidden,Array.new,Array.new,false)
            end
            
        def to_s
            super.to_s + " \nNumber of visible treasures = #{@nVisibleTreasures} \nNumber of hidden treasures = #{@nHiddenTreasures}"
        end    
        
        def adjustToFitTreasureLists(v,h)

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
            end  
            return bc
        end
        
        def substractVisibleTreasure(t)
            if @nVisibleTreasures != 0
              @nVisibleTreasures = @nVisibleTreasures - 1
            end
        end

        def substractHiddenTreasure(t)
            if @nHiddenTreasures != 0
                @nHiddenTreasures = @nHiddenTreasures - 1
            end
        end
        
        def isEmpty
            empty = false

            if(@levels == 0 and @nVisibleTreasures <= 0 and @nHiddenTreasures <= 0 and @death == false)
                    empty = true
            end
            return empty
        end
        
    end
end
