class MyMiniFb
  

 # @@SCOPE = "user_likes,email,publish_stream,user_birthday,user_checkins"  
  
  def authenticate 
    # Get your oauth url

                                  
    access_token_hash = MiniFB.oauth_access_token(FB_APP_ID, "http://www.yoursite.com/sessions/create", FB_SECRET, params[:code])
                                  
                                  
    # Have your users click on a link to @oauth_url
    
    # Then in your /sessions/create
    #access_token_hash = MiniFB.oauth_access_token(FB_APP_ID, "http://www.yoursite.com/sessions/create", FB_SECRET, params[:code])
    #@access_token = access_token_hash["access_token"]
    # TODO: This is where you'd want to store the token in your database
    # but for now, we'll just keep it in the cookie so we don't need a database
    #cookies[:access_token] = @access_token
  end
   
end
