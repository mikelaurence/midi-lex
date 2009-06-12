$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

framework 'macruby-midi'

require 'midi_lex'
include MidiLex::Messages::Channel

sender = MidiLex::Sender.new(:mac_ruby)



