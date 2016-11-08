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
    
    
    prize = Prize.new(2, 1)    
    bad_consequence = BadConsequence.new_bad_consequence_specific("Pierdes tu armadura visible y otra oculta", 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
    @unusedMonsters << Monster.new("3 Byakhees de bonanza", 8, prize, bad_consequence)

    prize = Prize.new(1, 1)
    bad_consequence = BadConsequence.new_bad_consequence_specific("Embobados con el lindo primigenio te descartas de tu casco visible", 0, [TreasureKind::HELMET], [])
    @unusedMonsters << Monster.new("Tenochtitlan", 2, prize, bad_consequence)

    prize= Prize.new(1, 1)
    bad_consequence = BadConsequence.new_bad_consequence_specific("El primordial bostezo contagioso. Pierdes el calzado visible", 0, [TreasureKind::SHOE], [])
    @unusedMonsters << Monster.new("El sopor de Dunwich", 2, prize, bad_consequence)

    prize = Prize.new(4, 1)
    bad_consequence = BadConsequence.new_bad_consequence_specific("Te atrapan para llevarte de fiesta y te dean caer en mitad del vuelo. Descarta 1 mano visible y otra oculta.", 0, [TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
    @unusedMonsters << Monster.new("Demonios de Magaluf", 2, prize, bad_consequence)

    prize = Prize.new(3, 1)
    bad_consequence = BadConsequence.new_bad_consequence_number("Pierdes todos tus tesoros visibles", 0, 10, 0)
    @unusedMonsters << Monster.new("El gorron en el umbral", 10, prize, bad_consequence)

    prize = Prize.new(2, 1)
    bad_consequence = BadConsequence.new_bad_consequence_specific("Pierdes la armadura visible", 0, [TreasureKind::ARMOR], [])
    @unusedMonsters << Monster.new("H.P. Munchcraft", 6, prize, bad_consequence)

    prize = Prize.new(1, 1)
    bad_consequence = BadConsequence.new_bad_consequence_specific("Sientes bichos bajo la ropa. Descarta la armadura visible", 0, [TreasureKind::ARMOR], [])
    @unusedMonsters << Monster.new("Necrofago", 13, prize, bad_consequence)

    prize = Prize.new(3, 2)
    bad_consequence = BadConsequence.new_bad_consequence_number("Pierdes 5 niveles y 3 tesoros visibles", 5, 3, 0)
    @unusedMonsters << Monster.new("El rey de rosado", 11, prize, bad_consequence)

    prize = Prize.new(1,1)
    bad_consequence = BadConsequence.new_bad_consequence_number("Toses los pulmones y pierdes 2 niveles",2,0,0)
    @unusedMonsters << Monster.new("Flecher",2,prize,bad_consequence)

    prize = Prize.new(2,1)
    bad_consequence = BadConsequence.new_bad_consequence_death("Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estas muerto", true)
    @unusedMonsters << Monster.new("Los hondos",8,prize,bad_consequence)

    prize = Prize.new(2,1)
    bad_consequence = BadConsequence.new_bad_consequence_number("Pierdes 2 niveles y 2 tesoros ocultos",2,0,2)
    @unusedMonsters << Monster.new("Semillas Cthulhu",4,prize,bad_consequence)

    prize = Prize.new(2,1)
    bad_consequence = BadConsequence.new_bad_consequence_specific("Te intentas escaquear. Pierdes una mano visible",0,[TreasureKind::ONEHAND],[])
    @unusedMonsters << Monster.new("Dameargo",1,prize,bad_consequence)

    prize = Prize.new(2,1)
    bad_consequence = BadConsequence.new_bad_consequence_number("Da mucho asquito. Pierdes 3 niveles", 3, 0, 0)
    @unusedMonsters << Monster.new("Pollipolipo volante",3,prize,bad_consequence)

    prize = Prize.new(3,1)
    bad_consequence = BadConsequence.new_bad_consequence_death("No le hace gracia que pronuncien mal su nombre. Estas muerto",true)
    @unusedMonsters << Monster.new("Yskhtihyssg-Goth",14,prize,bad_consequence)

    prize = Prize.new(3,1)
    bad_consequence = BadConsequence.new_bad_consequence_death("La familia te atrapa. Estas muerto",true)
    @unusedMonsters << Monster.new("Familia feliz",1,prize,bad_consequence)

    prize = Prize.new(2,1)
    bad_consequence = BadConsequence.new_bad_consequence_specific("La quinta directiva primaria te obliga a perder 2 niveles y un tesoro 2 manos visibles", 2,[TreasureKind::BOTHHAND],[])
    @unusedMonsters << Monster.new("Roboggoth",8,prize,bad_consequence)

    prize = Prize.new(1,1)
    bad_consequence = BadConsequence.new_bad_consequence_specific("Te asusta en la noche. Pierdes un casco visible",0,[TreasureKind::HELMET],[])
    @unusedMonsters << Monster.new("El espia sordo",5,prize,bad_consequence)

    prize = Prize.new(2,1)
    bad_consequence = BadConsequence.new_bad_consequence_number("Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles", 2, 5, 0)
    @unusedMonsters << Monster.new("Tongue",19,prize,bad_consequence)

    prize = Prize.new(2,1)
    bad_consequence = BadConsequence.new_bad_consequence_number("Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos",3,10,0)
    @unusedMonsters << Monster.new("Bicefalo",21,prize,bad_consequence)
    
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

