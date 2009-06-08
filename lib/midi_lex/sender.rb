#
# Note: much of this code is taken from Ben Bleything's MIDIator gem.
#
# == Authors
#
# * Ben Bleything <ben@bleything.net>
#
# == Contributors
#
# * Jeremy Voorhis <jvoorhis@gmail.com>
#
# == Copyright
#
# Copyright (c) 2008 Ben Bleything
#
# This code released under the terms of the MIT license.
#

module MidiLex
  
  ### Base class for MIDI output
  class Sender < Messenger
    
    include MidiLex::Messages::Channel

    ### Shortcut to send a note_on message.
    def note_on(channel, pitch, velocity = 64)
      self << [0x90 | channel, pitch, velocity]
    end
    

    ### Shortcut to send a note_off message.
    def note_off(channel, pitch, velocity = 0)
      self << [0x80 | channel, pitch, velocity]
    end
    

    ### Shortcut to send a polyphonic aftertouch message for an individual note.
    def aftertouch(channel, pitch, pressure = 64)
      self << [0xa0 | channel, pitch, pressure]
    end
    

    ### Shortcut to send a control change.
    def control_change(channel, number, value = 64)
      self << [0xb0 | channel, number, value]
    end


    ### Shortcut to send a program_change message.
    def program_change(channel, program)
      self << [0xc0 | channel, program]
    end


    ### Shortcut to send a channel aftertouch message.
    def channel_aftertouch(channel, pressure)
      self << [0xd0 | channel, pressure]
    end


    ### Shortcut to send a pitch bend message.
    def pitch_bend(channel, value)
      self << [0xe0 | channel, value]
    end
    alias bend pitch_bend
    
    ### Shortcut to send a sysex message.
    def sysex(*data)
      self << [0xf0] + data.flatten + [0xf7]
    end
    
  end
end