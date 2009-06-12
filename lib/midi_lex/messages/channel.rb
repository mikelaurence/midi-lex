module MidiLex
  module Messages
    module Channel

      include MidiLex::Messages::Core
      
      private
      
      class ChannelMessage < MidiMessage
        attr_accessor :channel, :data1, :data2
        
        def initialize(first, channel = 0, data1 = 0, data2 = nil)
          case first
          when Fixnum
            @channel = channel
            @data1 = data1
            @data2 = data2
          when Array
            @channel = first[0]
            @data1 = first[1]
            @data2 = first[2]
          end
        end
        
        def status
          raise "ChannelMessage#status must be implemented by subclasses"
        end
        
        def to_a
          @data2 ? [status | @channel, @data1, @data2] : [status | @channel, @data1]
        end
      end
      
      class NoteMessage < ChannelMessage
        alias :pitch :data1
        alias :velocity :data2
      end
      
      
      public
    
      class NoteOn < NoteMessage    
        def initialize(pitch, velocity = 64, channel = 0)
          super pitch, channel, pitch, velocity
        end
        
        def status; 0x90 end
      end
      
      class NoteOff < NoteMessage
        def initialize(pitch, channel = 0, velocity = 0)
          super pitch, channel, pitch, velocity
        end
        
        def status; 0x80 end
      end
      
      class Aftertouch < ChannelMessage
        alias :pitch :data1
        alias :pressure :data2
        
        def initialize(pitch, pressure = 0, channel = 0)
          super pitch, channel, pitch, pressure
        end
        
        def status; 0xa0 end
      end
      
      class ControlChange < ChannelMessage
        alias :number :data1
        alias :value :data2
        
        def initialize(number, value = 0, channel = 0)
          super number, channel, number, value
        end
        
        def status; 0xb0 end
        
        def to_s
          "[ControlChange] Channel: #{@channel}, Number: #{@number}, Value: #{@value}"
        end
      end
      
      class ProgramChange < ChannelMessage
        alias :program :data1
        
        def initialize(channel, program = 0)
          super channel, channel, program
        end
        
        def status; 0xc0 end
      end
      
      class ChannelAftertouch < ChannelMessage
        alias :pressure :data1
        def initialize(channel, pressure = 0)
          super channel, channel, pressure
        end
        
        def status; 0xd0 end
      end
      
      class PitchBend < ChannelMessage
        def initialize(channel, value = 8192)
          super channel, channel, value >> 4, value & 15
        end
        
        def status; 0xe0 end
      end
    
    end
  end
end