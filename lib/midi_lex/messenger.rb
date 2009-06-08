module MidiLex
  class Messenger
    
    include Driverable
    
    def open(name)
      raise %{Couldn't open port '#{name}' (availabe ports are #{ports.collect{|p| "'#{p}'" }.join(', ')})} unless open_port(name)
      self
    end
    
    def create(name)
      raise "Couldn't create virtual port '#{name}'" unless create_port(name)
      self
    end
    
    def num_ports
      ports.size
    end
  
  end
end