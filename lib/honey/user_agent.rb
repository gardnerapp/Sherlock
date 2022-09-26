module Sherlock
  module Honey
    class UserAgent
      def initialize(parent_ip_actor, uagent)
        @user_agent = uagent
        @web_requests = Set.new
      end

      def user_agent; @user_agent; end

      def web_requests; @web_requests; end

      def web_request_count= web_requests.length

      alias_method :to_s, :user_agent

      def add_web_request(log)
        @web_requests << WebRequest.new(self, log)
      end

    end
  end
end
