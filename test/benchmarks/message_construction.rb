$LOAD_PATH << File.join(File.dirname(__FILE__), '../../lib')

require 'benchmark'
require 'midi_lex'

Benchmark.bm(70) do |b|
  n = 900000
  
  b.report('@sender.note_on 100, 64, 0') {
    @sender = MidiLex::Sender.new(:test, :port => //)
    n.times {
      @sender.note_on 100, 64, 0
    }
  }
  b.report('@sender.note_on :pitch => 100, :velocity => 64, :channel => 0') {
    @sender = MidiLex::Sender.new(:test, :port => //)
    n.times {
      @sender.note_on :pitch => 100, :velocity => 64, :channel => 0
    }    
  }
  b.report('@sender << NoteOn.new(100, 64, 0)') {
    
    class NoteOn
      def initialize(pitch, velocity = 64, channel = 0)
        @pitch = pitch
        @velocity = velocity
        @channel = channel
      end
      def to_a
        [0x90 | @channel, @pitch, @velocity]
      end
    end
    
    @sender = MidiLex::Sender.new(:test, :port => //)
    n.times {
      @sender << NoteOn.new(100, 64, 0)
    }    
  }
  b.report('@sender << NoteOn.new(:pitch => 100, :velocity => 64, :channel => 0)') {
    
    class NoteOn
      def initialize(options = {})
        @pitch = options[:pitch]
        @velocity = options[:velocity]
        @channel = options[:channel]
      end
      def to_a
        [0x90 | @channel, @pitch, @velocity]
      end
    end
    
    @sender = MidiLex::Sender.new(:test, :port => //)
    n.times {
      @sender << NoteOn.new(:pitch => 100, :velocity => 64, :channel => 0)
    }    
  }
end