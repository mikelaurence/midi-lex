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
        
        def open_port(name)
          if @port = port(:realDestinations, name)
            @name = name
            @port.addSender(self) if @endpoint
            true
          end
        end
        
        def create_port(name)
          false
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
            @port.addReceiver(@receiver)
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
        def callback(target, method, frequency = 1.0 / 100.0)
          @timer = OSX::NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats_(1.0 / 100.0, target, method, nil, true)
          @runloop = OSX::NSRunLoop.currentRunLoop.addTimer_forMode(@timer, OSX::NSEventTrackingRunLoopMode)
        end
      end
      
    end
  end
end