module MidiMix
  class Receiver < Messenger
    
    include MidiMix::Receivable::Raw
    include MidiMix::Messages::Channel
    include MidiMix::Messages::Global
    
    def capture(options = {})
      raise "Must include a target for capturing MIDI data" unless @target = options[:target]
      @method = options[:method] || :capture
      self.extend "MidiMix::Receivable::#{options[:format].to_s.camelize}".constantize
      
      @timer ||= Timer.primary || Timer.new(@driver)
      @timer.add_callback self
      @timer.start :frequency => options[:frequency]
    end
    
    def tick
      if data = new_data?
        data.each { |d| process d }
      end
    end
    
    def filter_data(data)
      if data[0] < 0xf0
        data[0] = data[0] & 0xf
        return data
      elsif data[0] < 0xf6
        return data[1..-1]
      end
        []
    end
    
  end
  
end