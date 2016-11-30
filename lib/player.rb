# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.

require_relative 'bad_consequence.rb'
require_relative 'monster.rb'
require_relative 'treasure.rb'
require_relative 'treasure_kind.rb'
require_relative 'dice.rb'


module Napakalaki
    class Player
        attr_accessor :name, :level, :pendingBadConsequence, :visibleTreasures, :hiddenTreasures, :dead, :enemy, :canISteal
        
         def initialize(name)
            @name = name
            @level = 1
            @dead = true
            @visibleTreasures = Array.new
            @hiddenTreasures = Array.new
            @pendingBadConsequence = BadConsequence.newBadConsequenceN("", 0, -1, -1)
            @enemy = new PLayer
            @canISteal = false
        end
        
        # => Constructor de copia

        def copia(p)
            @name = p.name
            @level = p.level
            @dead = p.dead
            @visibleTreasures = p.visibleTreasures
            @hiddenTreasures = p.hiddenTreasures
            @pendingBadConsequence = p.pendingBadConsequence
            @enemy = p.enemy;
            @canISteal = p.canISteal
        end
        
        def isDead
            return @dead
        end
        
        def getName
            return @name
        end
        
        def getLevels
            return @level
        end
        
        def setEnemy(enemy)
            @enemy = enemy
        end
        
        def canISteal
            return @canISteal            
        end
        
        def haveStolen
            if canISteal
                @canISteal = true
            end
        end
        
        def getVisibleTreasures
            return @visibleTreasures
        end
        
        def initTreasures
            dealer = CardDealer.instance
            dice = Dice.instance

            bringToLife

            treasure = dealer.nextTreasure

            @hiddenTreasures << treasure

            number = dice.nextNumber

            if number > 1 
                treasure = dealer.nextTreasure
                @hiddenTreasures << treasure
            end

            if number == 6
                treasure = dealer.nextTreasure
                @hiddenTreasures << treasure
            end
        end
        
        def validState
            validState = false
            if (@pendingBadConsequence.empty? && @hiddenTreasures.size <=4)
                validState = true
            end
            return validState
        end
        
        def getHiddenTreasures
            return @hiddenTreasures
        end
        
        def combat(m)
            myLevel = getCombatLevel
            monsterLevel = getOponentLevel(m)
            return m.getBasicValue            
            if myLevel > monsterLevel
                applyPrize(m)
                if @level >= 10 
                    combatResult = CombatResult::WINANDWINGAME
                else
                    combatResult = CombatResult::WIN
                end
            else
                dice = Dice.instance
                escape = dice.nextNumber
                if escape < 5
                    amIDead = false
                    amIDead = m.kills
            
                    if amIDead
                        die
                        combatResult = CombatResult::LOSEANDDIE
                    else
                        bad = m.badConsequence
                        applyBadConsequence(bad)
                        combatResult = CombatResult::LOSE
                        if shouldConvert 
                            combatResult = CombatResult::LOSEANDCONVERT
                        end
                    end
                else
                    combatResult = CombatResult::LOSEANDESCAPE
                end
            end

            discardNecklaceIfVisible

            return combatResult

        end
      
        def makeTreasureVisible(t)
            canI = canMakeTreasureVisible(t)
        
            if canI
                @visibleTreasures << t
                @hiddenTreasures.delete(t)
            end
        
        end
      
        def discardVisibleTreasure(t)
            @visibleTreasures.delete(t)
            if (@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty)
                @pendingBadConsequence.substractVisibleTreasure(t)
            end
            dieIfNoTreasures
        end
      
        def discardHiddenTreasure(t)
            @hiddenTreasures.delete(t)
            if(@pendingBadConsequence != nil && !@pendingBadConsequence.isEmpty)
                @pendingBadConsequence.substractHiddenTreasure(t)
            end
            dieIfNoTreasures
        end
        
        def to_s
            "Name: #{@name}\tLevel: #{@level}"
        end
        
    private
        
        def bringToLife
            @death = false
        end
        
        def incrementLevels(l)
            @level = @level + l
          
            if (@level > 10)
                @level = 10
            end
        end
        
        def decrementLevels(l)
            @level = @level - l
          
            if(@level < 1)
                @level = 1
            end
        end
        
        def getCombatLevel()
            combatLevel = @level
            dice = Dice.instance
            tieneCollar = false

            @visibleTreasures.each do |t|
                if t.type == TreasureKind::NECKLACE
                    tieneCollar == true
                end
            end

            if tieneCollar
                for t in @visibleTreasures
                    combatLevel = combatLevel + t.maxBonus
                end

            else
                for t in @visibleTreasures
                    combatLevel = combatLevel + t.minBonus
                end          
            end
         
            return combatLevel 
        end
        
        def setPendingBadConsequence(b)
            @pendingBadConsequence = b
        end
                                        
        def dieIfNoTreasures
            if (@visibleTreasures.empty? && @hiddenTreasures.empty?)
                @dead = true
            end
        end
        
        def howManyVisibleTreasures(tKind)
            nTreasures = 0

            for t in @visibleTreasures
                if t.type == tKind
                    nTresaures = nTreasures + 1
                end
            end

            return nTreasures
        end
        
        def canYouGiveMeATreasure
            if (@hiddenTreasures.empty? && @visibleTreasures.empty?)
                return false
            else
                return true
            end
        end
        
        def canMakeTreasureVisible(t)
            canI     = false
            armor = 0
            onehand = 0
            bothhand = 0
            helmet = 0
            shoe = 0
            necklace = 0

            @visibleTreasures.each {|tr|
                tr.getType == TreasureKind::ARMOR    ? armor   = armor + 1     : armor
                tr.getType == TreasureKind::ONEHAND  ? onehand = onehand + 1   : onehand
                tr.getType == TreasureKind::BOTHHAND ? bothhand = bothhand + 1 : bothhand
                tr.getType == TreasureKind::HELMET   ? helmet = helmet + 1     : helmet
                tr.getType == TreasureKind::SHOE     ? shoe = shoe + 1         : shoe
                tr.getType == TreasureKind::NECKLACE ? necklace = necklace + 1 : necklace
            }

            if ((armor == 0) && (tr.getType == TreasureKind::ARMOR))
                canI = true
            elsif((onehand < 2) && (bothhand == 0) && (tr.getType == TreasureKind::ONEHAND))
                canI = true
            elsif((bothhand == 0) && (onehand == 0) && (tr.getType == TreasureKind::BOTHHAND))
                canI = true
            elsif((helmet == 0) && (tr.getType == TreasureKind::HELMET))
                canI = true
            elsif((shoe == 0) && (tr.getType == TreasureKind::SHOE))
                canI = true
            elsif((necklace == 0) && (tr.getType == TreasureKind::NECKLACE))
                canI = true 
            end

            return canI;
        end

    end
end
