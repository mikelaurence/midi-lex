module MidiMix
  module Receivable
    module Raw
      private

      def process(data)
        @target.send @method, data
      end
    end

    module Typed
      private

      def process(data)


      end
    end

    module Message
      private

      def process(data)


      end
    end
  end
end