module MidiLex
  module Receivable
    module Raw
      private

      def process(data)
        @target.send @method, data
      end
    end

    module Typed
      include MidiLex::Messages::Channel
      include MidiLex::Messages::Global

      private
      
      def process(data)
        status = data[0] < 0xf0 ? data[0] & 0xf0 : data[0]
        klass = case(status)
        when 0x80; NoteOff
        when 0x90; NoteOn
        when 0xa0; Aftertouch
        when 0xb0; ControlChange
        when 0xc0; ProgramChange
        when 0xd0; ChannelAftertouch
        when 0xe0; PitchBend
        when 0xf0; Sysex
        end
        
        msg = nil
        begin
          msg = klass.new(*filter_data(data))
        rescue
          puts "[Receivable::Typed] Error creating #{klass} with #{data.size} args: #{filter_data(data).inspect}"
        end
        
        @target.send @method, msg if msg
      end
    end

    module Message
      private

      def process(data)
        status = data[0] < 0xf0 ? data[0] & 0xf0 : data[0]
        method = case(status)
        when 0x80; :note_off
        when 0x90; :note_on
        when 0xa0; :aftertouch
        when 0xb0; :control_change
        when 0xc0; :program_change
        when 0xd0; :channel_aftertouch
        when 0xe0; :pitch_bend
        when 0xf0; :sysex
        end

        @target.send method, *filter_data(data)
      end
    end
  end
end