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
  @fbcookie = parse_fb_cookie
  if @fbcookie.nil? then return false end
  begin
    @uid = MiniFB.rest(@fbcookie["access_token"], "users.getLoggedInUser", {})
    if @uid.to_hash["response"] == current_user.fbid then return true else return false end 
  rescue MiniFB::FaceBookError #Is this error happen the token expired
    return false
  end
  #The user is authenticated if the UID than own the token is the same as the one in current user
end

def delete_fb_cookie
  cookies.delete("fbs_#{FB_APP_ID}".to_sym)
end


def facebook_js
  render :partial => "facebook/fbjs"
end


def facebook_login
  return "<fb:login-button></fb:login-button>"
end

#TBD: Save the url in the DB. 50x50 px
def facebook_pic_url
  return "http://graph.facebook.com/#{current_user.fbid}/picture?type=square"
end
