# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.
module Napakalaki
    class CultistPlayer < Player
        
        attr_accessor :myCultistCard, :totalCultistPlayer
        
        @@totalCultistPlayer = 0
        
        def initialize(p, c)
            super(p.name)
            copia(p)
            @myCultistCard = c
            @@totalCultistPlayer += 1
        end
        
        def shouldConvert
            return false
        end
        
        def getCombatLevel
     
            combat = super.getCombatLevel + super.getCombatLevel * 0.7
            combat += @myCultistCard.getGainedLevels * @@totalCultistPlayers

            return combat        
        end
        
        def getOponentLevel(m)
            return m.getCombatLevelAgainstCultistPlayer          
        end
        
        def giveMeATreasure
            @visibleTreasures.at(rand(@visibleTreasures.length + 1))
        end
        
        def canYouGiveMeATreasure
            if @visibleTreasures.empty?
                return false
            else
                return true
            end
        end
    end
end
