#
# $ => variavel global
# @ => variavel de instancia
# @@ => variavel de clase
# "<" => hereda de
#static TreasureKind       treasure;

require_relative 'prize.rb'
require_relative 'bad_consequence.rb'
require_relative 'treasure_kind.rb'
require_relative 'prize.rb'
require_relative 'monster.rb'

module Napakalaki
  
  class PruebaNapakalaki
    @unusedMonsters = Array.new
    @printMonsters = Array.new
    
    def initialize(tamMonsters, name, combatLevel, prize, badConsequence)
      super(name, combatLevel, prize, badConsequence)
      @tamMonsters = tamMonsters    
    end
  
    puts "\n------------------Nivel de combate superior a 10------------------\n"
    @printMonsters.delete_if {!@printMonsters.empty? }
    @unusedMonsters.each { |m| 
      if m.higher_level(10)
        #puts m.name + "\n"
        @printMonsters << m
      end
    }
    @printMonsters.each { |m| print m }
    #@printMonster.clear
    
    puts "\n-------------PRUEBA - Nivel de combate superior a 10------------------\n"
    @printMonsters.each { |m| print m }
    
    puts "\n---------------------Solo perdida de niveles----------------------\n"
    @printMonsters.delete_if {!@printMonsters.empty? }
    @unusedMonsters.each { |m| 
      if (m.get_loss_levels) 
        #puts m.name + "\n"
        @printMonsters << m
      end
    }
    @printMonsters.each { |m| print m}
    
    
    puts "\n----------------Ganancia de niveles superiores a 1------------------\n"
    @printMonsters.delete_if {!@printMonsters.empty? }  
    @unusedMonsters.each { |m| 
      @printMonsters << m if (m.greed_levels(1))
    }  
    
    @printMonsters.each { |m| print m}
   
    
  puts "\n------------------Perdida de tesoros especificos--------------------\n"
    @printMonsters.delete_if {!@printMonsters.empty? }
    @unusedMonsters.each { |m| 
      if (m.get_bad_spec_v.include?(TreasureKind::ARMOR) || m.get_bad_spec_h.include?(TreasureKind::ARMOR))
        @printMonsters << m
      end
     
      #if (m.get_bad_spec_v.include?(TreasureKind::ARMOR))
      #  puts m.name + ", tesoro visible => " + m.get_bad_spec_v.to_s + "\n"
      #end
      
      #if (m.get_bad_spec_h.include?(TreasureKind::ARMOR))
      #  puts m.name + ", tesoro oculto => " + m.get_bad_spec_h.to_s + "\n"        
      #end
    }
    @printMonsters.each { |m| print m}
    
  
  end

end
  










# class Language
#   def initialize(name, creator)
#     @name = name
#    @creator = creator
#   end
# 	
#   def description
#     puts "Eu sou #{@name} e fui criado por #{@creator}!"
#   end
# end
# class Specific < Language
#   def initialize(name, creator, date)
#     super(name, creator)
#     @date = date
#   end
	
#   def description
#     puts "Eu sou #{@name} e fui criado por #{@creator} no ano de #{@date}!"
#   end
# end
# ruby = Language.new("Ruby", "Yukihiro Matsumoto")
# python = Language.new("Python", "Guido van Rossum")
# javascript = Language.new("JavaScript", "Brendan Eich")
# cpluplus = Specific.new("C++", "Bjarne Stroustrup", "1979")

# ruby.description
# python.description
# javascript.description
# cpluplus.description

