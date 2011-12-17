#Here I've written the code to offer methods to simplify FB connections, like login links for example
#OR methods required outside of the facebook controller inside the gem

def parse_fb_cookie
  return MiniFB.parse_cookie_information FB_APP_ID, cookies
end

def user_from_fb?
  if signed_in? then
  return !current_user.fbid.blank? #If that's not blank then its a FB user
  else return false end
end

#Si da false entonces el usuario se le deniega el acceso
def authenticated_fbu?
  token = cookies[:fb_token]
  if token.nil? then return false end
  if token_user(token) == current_user.fbid then return true else return false end 
  #The user is authenticated if the UID than own the token is the same as the one in current user
end

def token_user(token)
  begin
    @uid = MiniFB.rest(token, "users.getLoggedInUser", {})
    return @uid.to_hash["response"]
  rescue MiniFB::FaceBookError #Is this error happen the token expired
    return nil
  end
end




def facebook_js
  render :partial => "facebook/fbjs"
end

def facebook_login
    return "<fb:login-button scope='publish_stream,email'></fb:login-button>"
end

def sign_out_link(msg="Sign out")
  if user_from_fb? then
    return "<a href='#' onClick='javascript:FB.logout();'>#{msg}</a>"
  else
    return "<a href='/sign_out'>#{msg}</a>"  
  end
end


#TBD: Save the url in the DB. 50x50 px
def facebook_pic_url
  return "http://graph.facebook.com/#{current_user.fbid}/picture?type=square"
end

#
# CODE FOR FB LIKE
#
#query = "SELECT like_count FROM link_stat WHERE url=#{myurl}"

def like_count(myurl)
  #myurl = "http://challenge.mistter.me:3000/projects/1"
  query = "SELECT like_count FROM link_stat WHERE url=\"#{myurl}\""
  return facebook_fql(query)[0].like_count  
end

# Executes an FQL query
def facebook_fql(fql_query, options={})
    url = "https://api.facebook.com/method/fql.query"
    params = options[:params] || {}
    params["metadata"] = "1" if options[:metadata]
    params["format"] = "JSON"
    params["query"] = fql_query
    options[:params] = params
    return fetch_url(url, options)
end

#Fetch something fro FB
def fetch_url(url, options={})
    begin
        if options[:method] == :post
            puts 'url_post=' + url #if @@logging
            resp = RestClient.post url, options[:params]
        else
            if options[:params] && options[:params].size > 0
                url += '?' + options[:params].map { |k, v| URI.escape("%s=%s" % [k, v]) }.join('&')
            end
            puts 'url_get=' + url #if @@logging
            resp = RestClient.get url
        end

        puts 'resp=' + resp.to_s #if @@logging

        begin
            res_hash = JSON.parse(resp.to_s)
        rescue
            # quick fix for things like stream.publish that don't return json
            res_hash = JSON.parse("{\"response\": #{resp.to_s}}")
        end

        if res_hash.is_a? Array # fql  return this
            res_hash.collect! { |x| Hashie::Mash.new(x) }
        else
            res_hash = Hashie::Mash.new(res_hash)
        end

        if res_hash.include?("error_msg")
            raise FaceBookError.new(res_hash["error_code"] || 1, res_hash["error_msg"])
        end

        return res_hash
    rescue RestClient::Exception => ex
        puts ex.http_code.to_s
        puts 'ex.http_body=' + ex.http_body #if @@logging
        res_hash = JSON.parse(ex.http_body) # probably should ensure it has a good response
        raise MiniFB::FaceBookError.new(ex.http_code, "#{res_hash["error"]["type"]}: #{res_hash["error"]["message"]}")
    end

end
