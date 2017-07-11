#
# $ => variavel global
# @ => variavel de instancia
# @@ => variavel de clase
# "<" => hereda de
# Shortcut                      Effect
# attr_reader :v                def v; @v; end
# attr_writer :v                def v=(value); @v=value; end
# attr_accessor :v              attr_reader :v; attr_writer :v
# attr_accessor :v, :w          attr_accessor :v; attr_accessor :w 

module Napakalaki
  class Prize
    
    attr_reader :treasures, :levels

    def initialize(treasure, level)
      @treasure = treasure
      @level = level
    end
    
    def get_prize_level
      return @level
    end
    
    def to_s
        "Number of treasures: #{@treasures} Number of Levels: #{@level}"
    end  
  end
end

