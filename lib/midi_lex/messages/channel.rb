module MidiLex
  module Messages
    module Channel

      include MidiLex::Messages::Core
      
      private
      
      class ChannelMessage < MidiMessage
        def initialize(status, channel, data1)
          @status = status
          @channel = channel
          @data1 = data1
        end
        
        def to_a
          [@status | @channel, @data1]
        end
      end
      
      class ExtendedChannelMessage < MidiMessage
        def initialize(status, channel, data1, data2)
          @status = status
          @channel = channel
          @data1 = data1
          @data2 = data2
        end
        
        def to_a
          [@status | @channel, @data1, @data2]
        end
      end
      
      class NoteMessage < ExtendedChannelMessage
        alias :pitch :data1
        alias :velocity :data2
               
        def to_a
          [@status | @channel, @pitch, @velocity]
        end
      end
      
      
      public
    
      class NoteOn < NoteMessage    
        def initialize(pitch, velocity = 64, channel = 0)
          super 0x90, channel, pitch, velocity
        end
      end
      
      class NoteOff < NoteMessage
        def initialize(pitch, channel = 0, velocity = 0)
          super 0x80, channel, pitch, velocity
        end      
      end
      
      class Aftertouch < ExtendedChannelMessage
        alias :pitch :data1
        alias :pressure :data2
        
        def initialize(pitch, pressure = 0, channel = 0)
          super 0xa0, channel, pitch, pressure
        end
      end
      
      class ControlChange < ExtendedChannelMessage
        alias :number :data1
        alias :value :data2
        
        def initialize(number, value, channel = 0)
          super 0xb0, channel, number, value
        end
      end
      
      class ProgramChange < ChannelMessage
        alias :program :data1
        
        def initialize(channel, program = 0)
          super 0xc0, channel, program
        end
      end
      
      class ChannelAftertouch < ChannelMessage
        alias :pressure :data1
        def initialize(channel, pressure = 0)
          super 0xd0, channel, pressure
        end
      end
      
      class PitchBend < ExtendedChannelMessage
        def initialize(channel, value = 8192)
          super 0xe0, channel, value >> 4, value & 15
        end
      end
    
    end
  end
end