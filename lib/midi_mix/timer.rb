module MidiMix
  class Timer

    include Driverable
    @@primary = nil
  
    def initialize(driver = nil)
      super driver
      @callbacks = []
    end
  
    def self.primary
      @@primary
    end
    
    def tick
      @callbacks.each { |c| c[0].send c[1] }
    end
    
    def add_callback(object, message = :tick)
      @callbacks.push [object, message] unless @callbacks.include?([object, message])
    end
    
    def remove_callbacks(object = nil, message = nil)
      @callbacks.delete { |c| (!object or object == c[0]) and (!message or message == c[1]) }
    end
  
  end
end