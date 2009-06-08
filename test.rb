$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'midi_lex'
include MidiLex::Messages::Channel

sender = MidiLex::Sender.new(:mac_core)



