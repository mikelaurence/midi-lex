module MidiLex
  module Drivers
    module Test
      
      module Sender        
        def ports
          ['Test Out 1', 'Test Out 2']
        end
        
        def open_port(name)
          true
        end
        
        def create_port(name)
          true
        end
        
        def <<(data)
          t = data.to_a
        end        
      end
      
      module Receiver        
        def ports
          ['Test In 1', 'Test In 2']
        end
        
        def open_port(name)
          true
        end
        
        def create_port(name)
          true
        end
        
        def new_data?
          nil
        end        
      end
      
      module Timer        
        def start(options = {})
        end
      end
      
    end
  end
end