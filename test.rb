$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'midi_mix'

sender = MidiMix::Sender.new(:mac_ruby)
puts sender.ports