#encoding: UTF-8
require_relative "napakalaki"
require_relative "GameTester"

module Napakalaki

  class EjemploMain
   
      def prueba
        
       test = Test::GameTester.instance
     
       game = Napakalaki.instance
   
       #Se prueba el juego con 2 jugadores
   
       test.play(game, 2);
       
      end
      
  end
  
    e = EjemploMain.new
    e.prueba()

end
