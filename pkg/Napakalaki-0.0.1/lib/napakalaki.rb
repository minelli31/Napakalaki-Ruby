# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.
require 'singleton'
require_relative 'combat_result.rb'
require_relative 'bad_consequence.rb'
require_relative 'card_dealer.rb'
require_relative 'player.rb'
require_relative 'prize.rb'

module Napakalaki
    class Napakalaki
        
        include Singleton
        attr_accessor :currentPlayer, :currentMonster, :players, :dealer, :currentPlayerIndex
        
        def initialize
            @players = Array.new
            @currentPlayer = nil
            @dealer = CardDealer.instance
            @currentMonster
            @currentPlayerIndex = -1
        end
        
        def developCombat
            combatResult = @currentPlayer.combat(@currentMonster)
            @dealer.giveMonsterBack(@currentMonster)
            return combatResult
        end
        
        def discardVisibleTreasures(treasures)
            treasures.each { |t|  
                @currentPlayer.discardVisibleTreasure(t)
                @dealer.giveTreasureBack(t)
            }            
        end
        
        def discardHiddenTreasures(treasures)
            treasures.each { |t|  
                @currentPlayer.discardHiddenTreasure(t)
                @dealer.giveTreasureBack(t)
            } 
        end
                
        def makeTreasuresVisible(treasures)
            treasures.each {|t|
                @currentPlayer.makeTreasureVisible(t)
            }            
        end
        
        def buyLevels(visible, hidden)
            
        end

        def initGame(players)
            initPlayers(players)
            setEnemies
            @dealer.initCards
            nextTurn
        end
        
        def nextTurn
            stateOK = nextTurnIsAllowed
            puts "Next Turn -> " + stateOK.to_s()
            
            if stateOK
                @currentMonster = @dealer.nextMonster
                @currentPlayer = nextPlayer
                if @currentPlayer.isDead 
                    @currentPlayer.initTreasures
                end
            end
            return stateOK
        end
        
        def endOfGame(result)
            result == CombatResult::WINGAME
        end
        
        def getCurrentPlayer
            @currentPlayer
        end
        
        def getCurrentMonster
            @currentMonster
        end
        
        private
        
        def setEnemies            
            @players.each { |p|
                begin
                    enemy = @players.at(rand(players.length + 1))                
                end while enemy == p
                p.setEnemy(enemy)
            }                  
        end
        
        def initPlayers(names)
            names.each { |name| 
                @players << Player.new(name)
            }
        end
        
        def nextPlayer
            if(@currentPlayerIndex == -1)             
                @currentPlayerIndex = rand(players.size)
            else
                @currentPlayerIndex = (@currentPlayerIndex + 1) % players.size
            end
            @currentPlayer = @players.at(@currentPlayerIndex)
        end
        
        def nextTurnIsAllowed
            stateOk = false
            if @currentPlayer == nil 
                stateOk = true
            else
                stateOk = @currentPlayer.validState
            end
        return stateOk
        end
    end
end
