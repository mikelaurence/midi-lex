module MidiMix
  class Receiver < Messenger
    
    def capture(target, method, frequency = 1.0 / 100.0)
      @timer ||= Timer.new(@driver)
    end
    
  end
end