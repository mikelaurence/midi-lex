module MidiLex
  module Messages
    module Channel

      include MidiLex::Messages::Core
      
      private
      
      class Note < MidiMessage
        attr_accessor :pitch, :channel, :velocity, :delta_time
        
        def initialize(channel, pitch, velocity = 64, delta_time = 0)
          @channel = channel
          @pitch = pitch
          @velocity = velocity
          @delta_time = delta_time
        end
        
        def to_a
          [STATUS | @channel, @pitch, @velocity]
        end
      end
      
      
      public
    
      class NoteOn < Note
        STATUS = 0x90
      
        def initialize(channel, pitch, velocity = 0, delta_time = 0)
          super(channel, pitch, velocity, delta_time)
        end      
      end
      
      class NoteOff < Note
        STATUS = 0x80
      
        def initialize(channel, pitch, velocity = 0, delta_time = 0)
          super(channel, pitch, velocity, delta_time)
        end      
      end
      
      class Aftertouch < Note
        STATUS = 0xA0
        
        def initialize(channel, pitch, pressure = 0)
          super(channel, pitch, pressure)
        end
      
        alias pressure velocity
        alias pressure= velocity=
      end
      
      class ControlChange < MidiMessage
        attr_accessor :channel, :number, :value
        STATUS = 0xb0
        
        def initialize(channel, number, value)
          @channel = channel
          @number = number
          @value = value
        end
        
        def to_a
          [STATUS | @channel, @number, @value]
        end
      end
      
      class ProgramChange < MidiMessage
        STATUS = 0xc0
      end
      
      class ChannelAftertouch < MidiMessage
        STATUS = 0xd0
      end
      
      class PitchBend < MidiMessage
        STATUS = 0xe0
      end
    
    end
  end
end