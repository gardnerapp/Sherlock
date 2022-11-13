# frozen_string_literal: true

require "sherlock"
describe Sherlock::Request do
  log = {
     "remote_addr": "185.7.214.117",
     "remote_user": "-",
     "time_local": "16/Aug/2022:08:46:06 +0000",
     "request": "GET /index.php?s=/Index/\x5Cthink\x5Capp/invokefunction&function=call_user_func_array&vars[0]=md5&vars[1][]=HelloThinkPHP21 HTTP/1.1",
     "status": "404",
     "body_bytes_sent": "1722",
     "http_referer": "-",
     "http_user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36"
   }

   %i[remote_addr time_local request status http_user_agent].each do |attr|
     it "Request has #{attr}" do
       req = Sherlock::Request.new(log)
       expect(eval("req.#{attr}")).to eql(log[attr])
     end
   end
end
