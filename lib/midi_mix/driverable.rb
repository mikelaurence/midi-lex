module MidiMix
  module Driverable
  
    def initialize(driver = nil)
      use_driver driver if driver
    end
    
    def use_driver(driver)
      @driver = driver
      require "midi_mix/drivers/#{driver}"
      self.class.class_eval "include MidiMix::Drivers::#{driver.to_s.camelize}::#{self.class.to_s.split('::').last}"
    end
  
  end
end