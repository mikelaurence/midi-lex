module MidiMix
  class Receiver < Messenger
    
    include MidiMix::Receivable::Raw
    
    def capture(options = {})
      raise "Must include a target for capturing MIDI data" unless @target = options[:target]
      @method = options[:method] || :capture
      self.class.class_eval "include MidiMix::Receivable::#{options[:format].to_s.camelize}"
      
      @timer ||= Timer.primary || Timer.new(@driver)
      @timer.add_callback self
      @timer.start :frequency => options[:frequency]
    end
    
    def tick
      if data = new_data?
        data.each { |d| process d }
      end
    end
    
  end
  
end