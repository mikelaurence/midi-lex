module MidiLex
  module Drivers
    module Rbcoremidi
      
      module Base
      end
      
      module Receiver
        
        raise "Error: you must use Ruby 1.9 or greater to utilize the rbcoremidi driver (your version is #{RUBY_VERSION})" unless RUBY_VERSION[0..2].to_f >= 1.9
        require File.dirname(__FILE__) + '/../../../ext/rbcoremidi/rbcoremidi.bundle'
        include CoreMIDI
        
        def ports
          API.get_sources
        end
        
        def open_port(name)
          if @port_number = ports.index(name)
            @name = name
            client = API.create_client('MidiLexClient')
            port = API.create_input_port(client, 'MidiLexPort')
            API.connect_source_to_port(@port_number, port)
            true
          end
        end
        
        def create_port(name)
          false
        end
        
        def new_data?
          API.peek
        end
        
      end
    end
  end
end