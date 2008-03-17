module Viddler
  module Rails
    module Controller
      def viddler_session
        @viddler_session ||= new_viddler_session
      end

      def new_viddler_session
        @viddler_session = Viddler::Session.create() 
      end
    end
  end
end
