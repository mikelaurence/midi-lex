$LOAD_PATH << File.join(File.dirname(__FILE__), '../lib')

require 'benchmark'
require 'midi_mix'

include MidiMix::Messages::Channel

def method(n)
  case(n)
  when 0x80
    NoteOff
  when 0x90
    NoteOn
  when 0xa0
    Aftertouch
  when 0xb0
    ControlChange
  when 0xc0
    ProgramChange
  when 0xd0
    ChannelAftertouch
  when 0xe0
    PitchBend
  end
end

Benchmark.bm(35) do |b|
  n = 300000
  b.report('Status byte lookup with hash') {
    n.times {
      j = { 0x80 => NoteOff, 0x90 => NoteOn, 0xa0 => Aftertouch, 0xb0 => ControlChange, 0xc0 => ProgramChange,
        0xd0 => ChannelAftertouch, 0xe0 => PitchBend }[0xd0]    
    }
  }
  b.report('Status byte lookup with case') {
    n.times {
      j = case(0xd0)
      when 0x80
        NoteOff
      when 0x90
        NoteOn
      when 0xa0
        Aftertouch
      when 0xb0
        ControlChange
      when 0xc0
        ProgramChange
      when 0xd0
        ChannelAftertouch
      when 0xe0
        PitchBend
      end
    }
  }
  b.report('Status byte lookup with case method') {
    n.times {
      j = method(0xd0)
    }
  }
end