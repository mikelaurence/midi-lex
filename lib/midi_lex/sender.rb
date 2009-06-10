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
    
    include MidiLex::Sendable::Default
    
  end
end