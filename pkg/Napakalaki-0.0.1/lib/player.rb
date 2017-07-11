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
            @pendingBadConsequence = nil #BadConsequence.new_bad_consequence_number("", 0, -1, -1)
            @enemy = nil
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
        
        def getVisibleTreasures
            return @visibleTreasures
        end
        
        def getOponentLevel(m)
            return m.getGainedLevel
        end
        
        def initTreasures
            dealer = CardDealer.instance
            dice = Dice.instance

            bringToLife

            treasure = dealer.nextTreasure

            @hiddenTreasures << treasure

            number = dice.nextNumber

            if number == 1 
                treasure = dealer.nextTreasure
                @hiddenTreasures << treasure
            elsif number == 6
                3.times {
                    treasure = dealer.nextTreasure
                    @hiddenTreasures << treasure
                }
            elsif number > 1 && number < 6
                2.times {
                    treasure = dealer.nextTreasure
                    @hiddenTreasures << treasure
                }
            end
        end
        
        def stealTreasure
            canI = @enemy.canISteal
            if canI
                canYou = @enemy.canYouGiveMeATreasure
                if canYou
                    @hiddenTreasures.add(@enemy.giveMeATreasure)
                    haveStolen
                end
            else
                canI = nil
            end
            return canI
        end
        
        def validState
            state = false
            puts "@pendingBadConsequence. -> " + @pendingBadConsequence.isEmpty.to_s()
             puts "@hiddenTreasures.size. -> " + @hiddenTreasures.size.to_s()
            if (@pendingBadConsequence.isEmpty && @hiddenTreasures.size <= 4)
                state = true
            end
            puts "validState -> " + state.to_s()
            return state
        end
        
        def getHiddenTreasures
            return @hiddenTreasures
        end
        
        #REVISAR
        def combat(m)
            myLevel = @level
            monsterLevel = m.combatLevel
            
            #puts "\n\n monsterLevel: " + monsterLevel.to_s() 
                
             if(!canISteal)
                dice = Dice.instance
                number = dice.nextNumber
                if(number < 3)
                    puts "\n\n m -> : " + m.getCombatLevel.to_s() 
                    enemyLevel = m.getCombatLevel
                    monsterLevel += enemyLevel
                end
            end
            
            if(myLevel > monsterLevel)
                applyPrize(m)
                if @level >= 10 
                    combatResult = CombatResult::WINGAME
                else
                    combatResult = CombatResult::WIN
                end
            else
                bad = m.badConsequence
                applyBadConsequence(bad)
                combatResult = CombatResult::LOSE
            end
            
            return combatResult

        end
      
        def makeTreasureVisible(t)
            canI = canMakeTreasureVisible(t)
            puts "Se puede? " + canI.to_s()
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
        
        def discardAllTreasures
            visibleT = Array.new
            @visibleTreasures.each { |vt|
                visibleT << vt
            }
            visibleT.each { |t|
                discardVisibleTreasure(t)
            }
            hiddenT = Array.new
            @hiddenTreasures.each { |ht|
                hiddenT << ht
            }
            hiddenT.each { |t|
                discardHiddenTreasure(t)
            }
        end
        
        def to_s
            "Name: #{@name}\tLevel: #{@level}"
        end
        
    private
        
        def haveStolen
            if canISteal
                @canISteal = true
            end
        end
        
        def applyPrize(m)
            nLevels = m.getLevelsGained
            incrementLevels(nLevels)
            nTreasures = m.getTreasuresGained
            if(nTreasures > 0)      
               0.upto(nTreasures) do |i|
                   dealer = CardDealer.instance
                   @hiddenTreasures.add(dealer.nextTreasure)
               end
            end
        end
        
        def applyBadConsequence(m)
            puts "decre -> " + m.levels.to_s()
            nLevels = m.levels
            puts "decre -> " + nLevels.to_s()
            decrementLevels(nLevels)
            puts "M decre -> " + m.levels.to_s()
            puts "@M specificHiddenTreasures -> " + m.specificHiddenTreasures.to_s()
            puts "@M specificHiddenTreasures -> " + m.specificHiddenTreasures.to_s()
            pendingBad = m.adjustToFitTreasureLists(@visibleTreasures,@hiddenTreasures)
            puts "pendingBad -> " + pendingBad.to_s()
            puts "@specificHiddenTreasures -> " + pendingBad.specificHiddenTreasures.to_s()
            puts "@specificHiddenTreasures -> " + pendingBad.specificHiddenTreasures.to_s()
            #@pendingBadConsequence = pendingBad
            setPendingBadConsequence(pendingBad)
        end
        
        def bringToLife
            @death = false
        end
        
        def incrementLevels(l)
            
            if @level == nil
                @level = 1
            end
            
            @level = @level + l
          
            if (@level > 10)
                @level = 10
            end
        end
        
        def decrementLevels(l)            
           # if @level == nil
            #     @level = 1
            # end
            puts "level -> " + @level.to_s()
            puts " L arg -> " + l.to_s()
            @level = @level - l
            puts "level L -> " + @level.to_s()
            if(@level < 1)
                @level = 1
            end
        end
        
        def getCombatLevel()
            combatLevel = @level
            dice = Dice.instance

            @visibleTreasures.each do |t|
                combatLevel += t.gainedLevels
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
        
        def giveMeATreasure
            @hiddenTreasures.at(rand(@hiddenTreasures.length + 1))
        end
        
        def canYouGiveMeATreasure
            if (@hiddenTreasures.empty? && @visibleTreasures.empty?)
                return false
            else
                return true
            end
        end
        
        def shouldConvert
            should = false

            dice = Dice.instance

            if dice.nextNumber == 6
                should = true
            end

            return should
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
                if tr.type == TreasureKind::ARMOR 
                    armor = armor + 1
                elsif tr.type == TreasureKind::ONEHAND
                    onehand = onehand + 1
                elsif tr.type == TreasureKind::BOTHHAND
                    bothhand = bothhand + 1
                elsif tr.type == TreasureKind::HELMET
                    helmet = helmet + 1
                elsif tr.type == TreasureKind::SHOE
                    shoe = shoe + 1
                elsif tr.type == TreasureKind::NECKLACE
                    necklace = necklace + 1                    
                end
            }
            if ((armor == 0) && (t.type == TreasureKind::ARMOR))
                canI = true
            elsif((onehand < 2) && (bothhand == 0) && (t.type == TreasureKind::ONEHAND))
                canI = true
            elsif((bothhand == 0) && (onehand == 0) && (t.type == TreasureKind::BOTHHAND))
                canI = true
            elsif((helmet == 0) && (t.type == TreasureKind::HELMET))
                canI = true
            elsif((shoe == 0) && (t.type == TreasureKind::SHOE))
                canI = true
            elsif((necklace == 0) && (t.type == TreasureKind::NECKLACE))
                canI = true 
            end            
            
            return canI;
        end

    end
end
