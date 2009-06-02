module MidiMix
  module Drivers
    module MacRuby
      
      module Base
        
        attr_reader :name
        
        def ports(type)
          PYMIDIManager.sharedInstance.send(type).collect{ |s| s.displayName }
        end
                
        def port(type, name)
          PYMIDIManager.sharedInstance.send(type).find{ |e| name.is_a?(Regexp) ? e.displayName =~ name : e.displayName == name }
        end
        
      end
      
      module Sender
        include Base
        
        def ports
          super(:realDestinations)
        end
        
        def open(name)
          if @port = port(:realDestinations, name)
            @name = name
            @endpoint.addSender(self) if @endpoint
          end
        end
        
        def create
          
        end
        
      end
      
      module Receiver
        include Base
        
        def ports
          super(:realSources)
        end
        
        def open(name)
          if @port = port(:realDestinations, name)
            @name = name
            @receiver = MidiReceiver.new
            @port.addReceiver(@receiver)
          end
        end
        
        def create(name)
          
        end
        
        def new_data?
          @receiver.newData
        end
        
      end      
      
    end
  end
end