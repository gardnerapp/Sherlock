module Sherlock
  module Honey
    LOG_ATTRIBUTES = %q[time_local remote_user request status body_bytes_sent http_referer]
    # With this brain dead simple trick I turned 24 lines of code into 4 !

    class WebRequest

      def initialize(parent_user_agent,log_hash)
          # define attributes
        LOG_ATTRIBUTES.each { |attr| eval("@#{attr} = log_hash[:#{attr}]") }
        @parent_user_agent = parent_user_agent
      end

      # define getter methods
      LOG_ATTRIBUTES.each do |attr|
        define_method "#{attr}" do
          attr
        end
      end # end meta program getter methods

      def parent_user_agent; @parent_user_agent; end

      def parent_ip_actor; @parent_user_agent.parent_ip_actor; end

    end # end web request class
  end # end honey module
end # end sherlock odule
