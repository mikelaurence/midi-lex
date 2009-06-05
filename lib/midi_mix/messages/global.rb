module MidiMix
  module Messages
    module Global
      
      include MidiMix::Messages::Core
      
      class Sysex < MidiMessage
        attr_accessor :data
        
        def initialize(*data)
          @data = data.flatten
        end
        
        def to_a
          [0xf0] + @data + [0xf7]
        end        
      end      
      
    end
  end
end