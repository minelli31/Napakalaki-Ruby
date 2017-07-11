# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.

require_relative 'player.rb'
module Napakalaki
    class Cultist < Player

        attr_reader :name, :gainedLevels

        def initialize(n, g)
            @name         = n;
            @gainedLevels = g;
        end

        @Override
        def getGainedLevels
            return @gainedLevels;
        end

        def getCombatLevelAgainstCultistPlayer
            return getGainedLevels * CultistPlayer.getTotalCultistPlayers
        end
    end
end
