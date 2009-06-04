module MidiMix
  module Drivers
    module MacCore
      
      module Sender
        require 'dl/import'
        
        module C # :nodoc:
          extend DL::Importable
          dlload '/System/Library/Frameworks/CoreMIDI.framework/Versions/Current/CoreMIDI'

          extern "int MIDIClientCreate( void*, void*, void*, void* )"
          extern "int MIDIClientDispose( void* )"
          extern "int MIDIGetNumberOfDestinations()"
          extern "void* MIDIGetDestination( int )"
          extern "int MIDIOutputPortCreate( void*, void*, void* )"
          extern "void* MIDIPacketListInit( void* )"
          extern "void* MIDIPacketListAdd( void*, int, void*, int, int, int, void* )"
          extern "int MIDISend( void*, void*, void* )"
        end

        module CF # :nodoc:
          extend DL::Importable
          dlload '/System/Library/Frameworks/CoreFoundation.framework/Versions/Current/CoreFoundation'

          extern "void* CFStringCreateWithCString( void*, char*, int )"
        end

        def ports
          (0..(C.mIDIGetNumberOfDestinations() - 1)).collect{ |n| C.mIDIGetDestination(n) }
        end
        
        def open_port(name)
          if @port_number = ports.index(name)
            @name = name
            client_name = CF.cFStringCreateWithCString(nil, "MidiMixClient", 0)
            @client = DL::PtrData.new(nil)
            C.mIDIClientCreate(client_name, nil, nil, @client.ref);

            port_name = CF.cFStringCreateWithCString(nil, "MidiMixPort", 0)
            @port = DL::PtrData.new(nil)
            C.mIDIOutputPortCreate(@client, port_name, @port.ref);

            num = C.mIDIGetNumberOfDestinations()
            #raise NoMIDIDestinations if num < 1
            @destination = C.mIDIGetDestination(@port_number)
            true
          end
        end
        
        def create_port(name)
          false
        end
        
        def <<(data)
          format = "C" * data.size
          bytes = data.pack( format ).to_ptr
          packet_list = DL.malloc( 256 )
          packet_ptr = C.mIDIPacketListInit( packet_list )

          # Pass in two 32-bit 0s for the 64 bit time
          packet_ptr = C.mIDIPacketListAdd( packet_list, 256, packet_ptr, 0, 0, data.size, bytes )

          C.mIDISend( @port, @destination, packet_list )
        end
        
        def close
          C.mIDIClientDispose( @client )
        end
        
      end
      
    end
  end
end