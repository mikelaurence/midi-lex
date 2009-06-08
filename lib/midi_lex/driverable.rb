module MidiLex
  module Driverable
  
    def initialize(driver = nil, options = {})
      use_driver driver if driver
      open options[:port] if respond_to?(:open) and options[:port]
    end
    
    def use_driver(driver)
      @driver = driver
      require "midi_lex/drivers/#{driver}"
      extend "MidiLex::Drivers::#{driver.to_s.camelize}::#{self.class.to_s.split('::').last}".camelize.constantize
    end
  
  end
end