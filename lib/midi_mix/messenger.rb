module MidiMix
  class Messenger
    
    include Driverable
    
    def open(name)
      raise "Couldn't open port named '#{name}'" unless open_port(name)
    end
    
    def create(name)
      raise "Couldn't create virtual port named '#{name}'" unless create_port(name)
    end
  
  end
end