framework 'macruby-midi'

module MidiLex
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
        
        def open_port(name)
          if @port = port(:realDestinations, name)
            @name = name
            @sender = MidiSender.new
            @sender.port = @port
            true
          end
        end
        
        def create_port(name)
          false
        end
        
        def message(*bytes)
          @sender.message bytes.flatten.collect{ |i| i.to_int }
        end
        
        def <<(data)
          @sender.message data.to_a
        end
        
      end
      
      module Receiver
        include Base
        
        def ports
          super(:realSources)
        end
        
        def open_port(name)
          if @port = port(:realSources, name)
            @name = name
            @receiver = MidiReceiver.new
            @receiver.port = @port
            true
          end
        end
        
        def create_port(name)
          false
        end
        
        def new_data?
          @receiver.newData
        end
        
      end
      
      module Timer
        
        def start(options = {})
          @timer = NSTimer.scheduledTimerWithTimeInterval(options[:frequency] || 1.0/100.0, target:self, selector: :tick, userInfo:nil, repeats:true)
          @runloop = NSRunLoop.currentRunLoop.addTimer(@timer, forMode:'NSRunLoopTrackingRunLoopMode')
        end

      end
      
    end
  end
end