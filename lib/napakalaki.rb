# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.
require 'singleton'
require_relative 'combat_result.rb'
require_relative 'card_dealer.rb'
require_relative 'player.rb'
require_relative 'bad_consequence.rb'
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
            
        end
        
        def discardVisibleTreasures(treasures)
            
        end
        
        def discardHiddenTreasures(treasures)
            
        end
        
        def makeTreasuresVisible(treasures)
            
        end
        
        def buyLevels(visible, hidden)
            
        end

        def initGame(players)
            
        end
        
        def nextTurn
            
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
            begin
                enemy = @players.at(rand(players.length + 1))                
            end until enemy == @currentPlayer 
                @currentPlayer.setEnemy(enemy)
        end
        
        def initPlayers(names)
            names.each { |name| 
                @players << PLayer.new(name)
            }
        end
        
        def nextPlayer()
            if(@currentPlayerIndex == -1)             
                @currentPlayerIndex = rand(players.size)
            else
                @currentPlayerIndex = (@currentPlayerIndex + 1) % players.size
            end
            @currentPlayer = @players.at(@currentPlayerIndex)
        end
        
        def nextTurnIsAllowed
            @currentPlayer.nil? ? true : @currentPlayer.validState
        end
        
    end
end
