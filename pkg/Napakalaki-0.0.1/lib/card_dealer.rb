#encoding: UTF-8
require 'singleton'
require_relative 'treasure.rb'
require_relative 'treasure_kind.rb'
require_relative 'prize.rb'
require_relative 'monster.rb'
require_relative 'specific_bad_consequence.rb'
require_relative 'bad_consequence.rb'
require_relative 'cultist.rb'

module Napakalaki
    class CardDealer
        
        include Singleton

        attr_accessor :unusedMonsters, :usedMonsters, :usedTreasures, :unusedTreasures, :usedCultists, :unusedCultists
            
        def nextTreasure
            if (@unusedTreasures.empty?)
                @usedTreasures.each {|t|
                    @unusedTreasures << t
                }
            end
            shuffleTreasures
            @usedTreasures.clear
            @unusedTreasures.at(0)
        end
                
        def nextMonster
            if (@unusedMonsters.empty?)
                @usedMonsters.each {|m|
                    @unusedMonsters << m
                }
            end
            shuffleMonsters
            @usedMonsters.clear
            @unusedMonsters.at(0)
        end
        
        def nextCultist
            if (@unusedCultists.empty?)
                @usedCultists.each {|c|
                    @unusedCultists << c
                }
            end
            shuffleCultists
            @usedCultists.clear
            @unusedCultists.at(0)
        end
        
        def giveTreasureBack(t)
            if !@usedTreasures.include?(t)
                @usedTreasures << t
            end
        end

        def giveMonsterBack(m)
            if !@usedMonsters.include?(m)
                @usedMonsters << m
            end
        end
        
        def giveCultistBack(c)
            if !@usedCultists.include?(c)
                @usedCultists << c
            end
        end
        
        def initCards
            initTreasureCardDeck
            initMonsterCardDeck
            initCultistCardDeck
        end
        
    private    
    
        def initialize
            @usedMonsters = Array.new
            @unusedMonsters = Array.new
            @usedTreasures = Array.new
            @unusedTreasures = Array.new
            @usedCultists = Array.new
            @unusedCultists = Array.new
        end
        
        def initTreasureCardDeck
            @unusedTreasures << Treasure.new('¡Si mi amo!',4,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Capucha de Cthulhu',3,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Botas de lluvia acida',1,TreasureKind::SHOE)
            @unusedTreasures << Treasure.new('Ametralladora Thompson',4,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Clavo de rail ferroviario',3,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Fez alopodo',3,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('El aparato de Pr. Tesla',4,TreasureKind::ARMOR)
            @unusedTreasures << Treasure.new('Insecticida',2,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Garabato mistico',2,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('La rebeca metalica',2,TreasureKind::ARMOR)
            @unusedTreasures << Treasure.new('Necroplayboycon',3,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Necrocomicon',1,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Linterna a dos manos',3,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Necrotelecom',2,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Tentaculo de pega',0,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Shogulador',1,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Varita de atizamiento',3,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Botas de investigación',3, TreasureKind::SHOE)
            @unusedTreasures << Treasure.new('A prueba de babas',2,TreasureKind::ARMOR)
            @unusedTreasures << Treasure.new('Casco minero',2,TreasureKind::HELMET)
            @unusedTreasures << Treasure.new('Camiseta de la UGR',1,TreasureKind::ARMOR)
            @unusedTreasures << Treasure.new('Cuchillo de sushi arcano', 2,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Hacha prehistorica', 2, TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Gaita', 4,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Escopeta de 3 cañones', 4,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('La fuerza de Mr.T', 0,TreasureKind::NECKLACE)
            @unusedTreasures << Treasure.new('Mazo de los antiguos', 3,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Lanzallamas', 4,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Necronomicón', 5,TreasureKind::BOTHHAND)
            @unusedTreasures << Treasure.new('Necro-gnomicón', 2,TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Porra preternatural', 2, TreasureKind::ONEHAND)
            @unusedTreasures << Treasure.new('Zapato deja-amigos', 0,TreasureKind::SHOE)
            shuffleTreasures
        end
        #new_bad_consequence_specific("Pierdes tu armadura visible y otra oculta", 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
        def initMonsterCardDeck   
            prize = Prize.new(2, 1)    
            bad_consequence = SpecificBadConsequence.new_bad_consequence_specific("Pierdes tu armadura visible y otra oculta", 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
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

            #############################################################################################################################################################################
            ## => Monstruos con sectarios
            #############################################################################################################################################################################

            prize = Prize.new(3,1)
            bad_consequence = BadConsequence.new_bad_consequence_specific('Pierdes 1 mano visible', 0, [TreasureKind::ONEHAND], nil)
            @unusedMonsters << Monster.new('El mal indecible impronunciable', 10, prize, bad_consequence, -2)

            prize = Prize.new(2,1)
            bad_consequence = BadConsequence.new_bad_consequence_number('Pierdes tus tesoros visibles. Ja ja ja', 0, 10, nil)
            @unusedMonsters << Monster.new('Testigos oculares', 6, prize, bad_consequence, 2)

            prize = Prize.new(2,5)
            bad_consequence = BadConsequence.new_bad_consequence_death('Hoy no es tu día de suerte. Mueres', true)
            @unusedMonsters << Monster.new('El gran Cthulhu', 20,prize, bad_consequence, 4)

            prize = Prize.new(2,1)
            bad_consequence = BadConsequence.new_bad_consequence_number('Tu gobierno te recorta dos niveles',2,0,0)
            @unusedMonsters << Monster.new('Serpiente político', 8, prize, bad_consequence, -2)

            prize = Prize.new(1,1)
            bad_consequence = BadConsequence.new_bad_consequence_specific('Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas', 0, [TreasureKind::HELMET, TreasureKind::ARMOR],
            [TreasureKind::ONEHAND, TreasureKind::BOTHHAND])
            @unusedMonsters << Monster.new('Felpuggoth', 2, prize, bad_consequence, 5)

            prize = Prize.new(4,2)
            bad_consequence = BadConsequence.new_bad_consequence_number('Pierdes 2 niveles', 2, 0, 0,)
            @unusedMonsters << Monster.new('Shoggoth',16, prize, bad_consequence, -4)

            prize = Prize.new(1,1)
            bad_consequence = BadConsequence.new_bad_consequence_specific('Pintalabios negro. Pierdes 2 niveles',2,0,0)
            @unusedMonsters << Monster.new('Lolitagooth', 2, prize, bad_consequence, 3)
            
            shuffleMonsters
        end
        
        def initCultistCardDeck
            @unusedCultists << Cultist.new('Sectario: +1 por cada sectario en juego. No puedes dejar de ser sectario', 1)
            @unusedCultists << Cultist.new('Sectario: +2 por cada sectario en juego. No puedes dejar de ser sectario', 2)
            @unusedCultists << Cultist.new('Sectario: +1 por cada sectario en juego. No puedes dejar de ser sectario', 1)
            @unusedCultists << Cultist.new('Sectario: +2 por cada sectario en juego. No puedes dejar de ser sectario', 2)
            @unusedCultists << Cultist.new('Sectario: +1 por cada sectario en juego. No puedes dejar de ser sectario', 1)
            @unusedCultists << Cultist.new('Sectario: +1 por cada sectario en juego. No puedes dejar de ser sectario', 1)
        end
        
        def shuffleTreasures
            @unusedTreasures.shuffle!
        end

        def shuffleMonsters
            @unusedMonsters.shuffle!
        end
       
        def shuffleCultists
            @unusedCultists.shuffle!
        end
        
    end  
end

