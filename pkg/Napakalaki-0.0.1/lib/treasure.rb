# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates and open the template
# in the editor.

require_relative 'treasure_kind.rb'

module Napakalaki
    
    class Treasure 
        
        attr_reader :namessss, :type

        def initialize (n, l, t)
            @name = n
            @level = l
            @type = t
        end

        def to_s
          "Name = #{@name} \nType = #{@type.to_s}"
        end

    end
end

