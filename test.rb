$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'midi_mix'
include MidiMix::Messages::Channel

sender = MidiMix::Sender.new(:mac_core)



