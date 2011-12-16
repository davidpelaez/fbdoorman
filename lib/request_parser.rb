# FROM https://github.com/nsanta/fbgraph/blob/master/lib/fbgraph/canvas.rb

def parse_signed_request(request)
        encoded_sig, payload = request.split('.', 2)
        sig = urldecode64(encoded_sig)
        data = JSON.parse(urldecode64(payload))
        if data['algorithm'].to_s.upcase != 'HMAC-SHA256'
          raise "Bad signature algorithm: %s" % data['algorithm']
        end
        expected_sig = OpenSSL::HMAC.digest('sha256', FB[:secret], payload)
        if expected_sig != sig
          raise "Bad signature"
        end
        data
      end
      
    
def urldecode64(str)
  encoded_str = str.tr('-_', '+/')
  encoded_str += '=' while !(encoded_str.size % 4).zero?
  Base64.decode64(encoded_str)
end