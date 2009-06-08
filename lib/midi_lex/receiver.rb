module MidiLex
  class Receiver < Messenger
    
    include MidiLex::Receivable::Typed
    include MidiLex::Messages::Channel
    include MidiLex::Messages::Global
    
    def capture(options = {}, &block)
      self.extend "MidiLex::Receivable::#{options[:format].to_s.camelize}".constantize if options[:format]
      
      if block_given?
        @target = self
        @method = :process_block
        @block = block
        while true
          tick 
          sleep 0.001
        end
      else
        
        raise "Must include a target for capturing MIDI data without block" unless @target = options[:target]
        @method = options[:method] || :capture
        
        @timer ||= Timer.primary || Timer.new(@driver)
        @timer.add_callback self
        @timer.start :frequency => options[:frequency]
      end
    end
    
    def tick
      if messages = new_data?
        messages.each { |m| process m.data }
      end
    end
    
    def process_block(data)
      @block.call data
    end
    
    def filter_data(data)
      if data[0] < 0xf0
        data[0] = data[0] & 0xf
        return data
      elsif data[0] < 0xf6
        return data[1..-2]
      end
        []
    end
    
  end
  
end