module MidiMix
  module Messages
    module Global
      
      class Sysex
        attr_accessor :data
        
        def initialize(data)
          @data = data          
        end
        
        def to_a
          [0xf0] + @data + [0xf7]
        end        
      end      
      
    end
  end
end