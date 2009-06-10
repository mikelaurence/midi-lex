module MidiLex
  module Sendable
    module Default
      
      ### Send a note_on message.
      def note_on(pitch, velocity = 64, channel = 0)
        self << [0x90 | (pitch[:channel] || channel), pitch[:pitch] || 57, pitch[:velocity] || velocity] and return if pitch.is_a?(Hash)
        self << [0x90 | channel, pitch, velocity]
      end

      ### Send a note_off message.
      def note_off(pitch, channel = 0)
        self << [0x80 | channel, pitch, 0]
      end

      ### Send a polyphonic aftertouch message for the given pitch.
      def aftertouch(pitch, pressure = 64, channel = 0)
        self << [0xa0 | channel, pitch, pressure]
      end

      ### Send a control change.
      def control_change(number, value = 64, channel = 0)
        self << [0xb0 | channel, number, value]
      end

      ### Send a program_change message.
      def program_change(channel, program)
        self << [0xc0 | channel, program]
      end

      ### Send a channel aftertouch message.
      def channel_aftertouch(channel, pressure)
        self << [0xd0 | channel, pressure]
      end

      ### Send a pitch bend message.
      def pitch_bend(channel, value)
        self << [0xe0 | channel, value]
      end
      alias bend pitch_bend

      ### Send a sysex message.
      def sysex(*data)
        self << [0xf0] + data.flatten + [0xf7]
      end
      
    end
  end
end