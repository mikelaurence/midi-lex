module MidiMix
  class Sender

    def initialize(driver = nil)
      if driver
        require "midi_mix/drivers/#{driver}"
        #self.class.class_eval "include MidiMix::Drivers::Senders::#{driver.to_s.camelize}"
        self.class.class_eval "include MidiMix::Drivers::#{driver.to_s.camelize}::Sender"
      end
    end

  end
end