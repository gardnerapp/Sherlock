module Sherlock
  ATTRIBUTES = %w[
    remote_addr remote_user time_local
    request status body_bytes_sent
    http_referer
    http_user_agent
  ] # set attributes to keys/values in log files

  class Request

    def initialize(log)
      # define attributes
      ATTRIBUTES.each { |attr| eval("@#{attr} = log[:#{attr}]") }
    end

    # define getter methods
    ATTRIBUTES.each do |attr|
      define_method "#{attr}" do
       eval("@#{attr}")
     end
    end # end meta program getter methods

  end # end web request class
end # end sherlock odule
