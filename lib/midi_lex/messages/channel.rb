module MidiLex
  module Messages
    module Channel

      include MidiLex::Messages::Core
      
      private
      
      class NoteMessage < MidiMessage
        attr_accessor :pitch, :channel, :velocity, :delta_time
        
        def initialize(pitch, velocity, channel, status)
          @pitch = pitch
          @velocity = velocity
          @channel = channel
          @status = status
        end
        
        def to_a
          [@status | @channel, @pitch, @velocity]
        end
      end
      
      
      public
    
      class NoteOn < NoteMessage    
        def initialize(pitch, velocity = 64, channel = 0)
          super(pitch, velocity, channel, 0x90)
        end      
      end
      
      class NoteOff < NoteMessage
        def initialize(pitch, channel = 0, velocity = 0)
          super(pitch, velocity, channel, 0x80)
        end      
      end
      
      class Aftertouch < NoteMessage      
        def initialize(pitch, pressure = 0, channel = 0)
          super(pitch, pressure, channel, 0xa0)
        end
      
        alias pressure velocity
        alias pressure= velocity=
      end
      
      class ControlChange < MidiMessage
        attr_accessor :channel, :number, :value
        STATUS = 0xb0
        
        def initialize(number, value, channel = 0)
          @number = number
          @value = value
          @channel = channel
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