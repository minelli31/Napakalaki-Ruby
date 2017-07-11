# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module Napakalaki
  class Monster
    attr_accessor :name, :combatLevel, :prize, :badConsequence
    
    def initialize(name, combatLevel, prize, badConsequence, levelChangeAgainstCultistPlayer = 0)
      @name = name
      @combatLevel = combatLevel
      @prize = prize
      @badConsequence = badConsequence
      @levelChangeAgainstCultistPlayer = levelChangeAgainstCultistPlayer
    end
    
    def getGainedLevel
            return getCombatLevel
    end
        
    def getCombatLevelAgainstCultistPlayer
        return @combatLevel + @levelChangeAgainstCultistPlayer
    end
        
    def getBadConsequence
      return @badConsequence
    end
    
    def getCombatLevel
      return @combatLevel
    end
      
    def getLevelsGained
        return @prize.levels
    end

    def getTreasuresGained
        return @prize.treasures
    end
    
    def getOponentLevel
        
    end
    
    def shouldConvert
        
    end
    
    def greed_levels(level)
      if @prize.get_prize_level > level
        return true
      else
        return false
      end
    end
    
    def higher_level(higher)
      if @combatLevel > higher
        return true
      else
        return false        
      end
    end
    
    def get_loss_levels
      if (get_bad_level != 0) && (get_bad_nv == 0) && (get_bad_nh == 0) && (get_bad_spec_v.empty?) && (get_bad_spec_h.empty?)
        return true
      else
        return false        
      end
    end
    #array.assoc(obj)
    
    def get_spec_treasure_v(t)
     if get_bad_spec_v.include?(t)
        return true
      else
        return false
     end
    end
    
    def get_spec_treasure_h(t)
      if get_bad_spec_h.include?(t)
        return true
      else
        return false
      end
    end
    
    def to_s
      "\nName = #{@name} \nCombat Level = #{@combatLevel} \nBadConsequence = #{@badConsequence} \nPrize #{@prize}"
    end
  end
end
