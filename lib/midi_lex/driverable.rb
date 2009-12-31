module MidiLex
  module Driverable
  
    def initialize(driver = nil, options = {})
      use_driver driver if driver
      open options[:port] if respond_to?(:open) and options[:port]
    end
    
    def use_driver(driver)
      @driver = driver
      require "midi_lex/drivers/#{driver}"
      driver_module = "MidiLex::Drivers::#{driver.to_s.camelize}"
      extend "#{driver_module}::Base".camelize.constantize
      extend "#{driver_module}::#{self.class.to_s.split('::').last}".camelize.constantize
    end
  
  end
end