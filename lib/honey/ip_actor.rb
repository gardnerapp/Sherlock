require "../file_helpers/file_helpers.rb"
require "./user_agent.rb"
require "set"

module Sherlock
  module Honey
    class IpActor

      def initialize(src_addr)
        @src_addr = src_addr
        # Sets only allow unique items and provide faster querying
        @user_agents = Set.new
      end

      def src_addr = @src_addr

      def user_agents
        @user_agents
      end

      def web_requests
        @user_agents.web_requests.map {|req| req }
      end

      def user_agent_count = user_agents.length

      def to_j
        {
          :ip_addr => ip_addr
        }
      end

      %i[to_json as_json].each {|a| alias_method a, :to_j}

      class << self

        # reads through a JSON formatted Log File and returns a list of self
        def init_from_logs(log_file)
           # parse the file into hash
           logs = Sherlock::FileHelpers.file_to_json(log_file)
           # map to array, get unique ip addr than map to new ip_actor instance
           actors = logs.map {|log| log[:remote_addr]}.uniq.map {|ip_addr| IpActor.new(ip_addr)}

           actors.each do |actor|
             # get all log entries with same ip as actor & add the user agents
             l = logs.filter_map { |l| l if l[:remote_addr] == actor.src_addr }

             # get all unique user agents and add them to the actor
             l.map {|l| l[:http_user_agent]}.uniq.each do |agent|
                actor.user_agents << Sherlock::Honey::UserAgent.new(actor, agent)
              end

              l.each do |log| # initialize web request
                if log[:remote_addr] == actor.src_addr
                  uagent = actor.user_agents.find {|agent| agent.to_s == log[:http_user_agent]}
                  uagent.add_web_request(log)
                end
              end
           end
           actors
        end # end init_from_logs

      end # End class Instance methods

    end # End IpActor
  end # end Honey module
end # end sherlock


a = Sherlock::Honey::IpActor.init_from_logs("../test_web_logs/sm_log.txt")

a.each do |a|
  puts "Actor Src Addr => \n\t#{a.src_addr}"
  puts "Actor User Agents =>"
  puts "\tNumber of agents => #{a.user_agents.length}"
  a.user_agents.each {|agent| puts agent.to_s}
  puts "\n"
end


# Organize JSON method
# make sure I can get all request and User agents from a given IP
# get correct count for requests and user agents
# integrate into command line interface and start porting lambda
# port to gem, add to path begin testing
