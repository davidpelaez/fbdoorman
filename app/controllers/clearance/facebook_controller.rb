class Clearance::FacebookController < ApplicationController

  #Js is informing that the cookie was created
  def index
    if signed_in? then 
        redirect_to LOGGED_PATH #Evita multiples logins y hace que solo tenga sentido llamar el metodo con un nuevo cookie
    else #If there's no signed in user
        #The code arrives here
        user_id = token_user(params[:token])
        if user_id != nil then
          @user = find_fbuser(user_id) #The one from the DB
          #If the user exists
          if @user then
            sign_in(@user, params[:token], params[:expiration])
            redirect_to LOGGED_PATH and return
          else #If theres no user with that id
            #Register this user
            register_fbu(params[:token])
          end   
        else #The token isn't valid
          closed
        end
    end 
  end
  
  #Js is informing that the query as cleared
  def closed
    sign_out
    render :template => "facebook/closed"
  end
  

  

  
  #Here I reply the create the new user, I changed te verifications so that fbid is unique and password is optional
  # when fbid isn't blank
  def register_fbu(token)
    #get the user from FB
    ##Works sometimes, others sends: JSON::ParserError Exception: source did not contain any JSON!  
    #Bucle posiblemente infinito y chambon para lidiar con la excepcion mientras se soluciona  
    incomplete = true
    while incomplete do
      begin  
        incomplete = false #Intento salir del bucle
        new_user = MiniFB::OAuthSession.new(token, 'es_ES').get "me" 
      rescue JSON::ParserError
        incomplete = true #Reingreso en el bucle
      end
    end
    
    #Build th user in DB
    @user = ::User.new
    @user.fbid = new_user.id
    @user.name = new_user.name
    @user.email2 = new_user.email 
    if @user.save
      sign_in(@user, params[:token], params[:expiration])
    else
      render :text => "Please contact the administrator, the Facebook user couldn't be created."
    end    
  end
  
  #This method return nil if theres no such user and the user if there is
  def find_fbuser(myfbuid)
    return ::User.find_by_fbid(myfbuid)
  end
  
  def fbtoken(mycode)
    access_token_hash = MiniFB.oauth_access_token(FB_APP_ID, FB_CALLBACK_URL, FB_SECRET, mycode)
    return access_token = access_token_hash["access_token"]
  end
  
end
