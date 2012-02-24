class TestController < ApplicationController

  @@fb_app_id = "230742003687043"
  @@website_url = "http://localhost:3000/test"
  @@fb_secret = "4e668d82dc087505075fc6261984f4df"
  @@code = " "

  def index
    
  MiniFB.scopes << "publish_checkins"
  @oauth_url = MiniFB.oauth_url(@@fb_app_id, 
                                   @@website_url,
                                  :scope=>MiniFB.scopes.join(",")) # This asks for all permissions
  @oauth_url = MiniFB.oauth_url(@@fb_app_id, 
                                   @@website_url,
                                  :scope=>"publish_checkins")                                  
                                  
  if params[:code] 
    access_token_hash = MiniFB.oauth_access_token(@@fb_app_id, @@website_url, @@fb_secret, params[:code])
    @access_token = access_token_hash["access_token"]
    cookies[:access_token] = @access_token
    @@code = @access_token
    
   
    
  end
  
   
   #MiniFB.scopes << "user_checkins"
  end
  
  def show 
        MiniFB.enable_logging
        @id = params[:id]
        @res = MiniFB.get(cookies[:access_token], @id, :type=>params[:type], :metadata=>true)   
        @user = MiniFB.get(cookies[:access_token], "me", :metadata=>true)  
        puts "scopes = #{MiniFB.scopes}"
        
  end
  
  def post 
        privacy = {}    
        privacy[:description] = "Public"
        privacy[:value] = nil
        privacy[:allow] = "0"
        privacy[:deny] = "0"

        place = {}   
        #place[:id] = "141184112585566"
        #place[:name] = "Tour Eiffel"
      
        location = {} 
        #location[:street] = "5, avenue Anatole France \u2013 Champ de Mars"
        #location[:city] = "Paris"
        #location[:country] = "France"
        #location[:zip] = "75007"
        location[:latitude] = 48.858481766789
        location[:longitude] = 2.2956111239207

        place[:location] = ActiveSupport::JSON.encode(location) #actions is an array encoded in JSON [{"link":"http://fb.me" ,"name":"Get credits"}]"
 
        @user = MiniFB.get(cookies[:access_token], "me", :metadata=>true) 
        @id = params.delete :id
        @to = params.delete :to
        params[:message] = "Eiffel tower"
        #params[:picture] = "http://profile.ak.fbcdn.net/hprofile-ak-snc4/161919_141184112585566_345056537_q.jpg"
        #params[:link] = "http://www.facebook.com/TourEiffel"
        #params[:name] = "Tour Eiffel"
        #params[:caption] = "Agathe checked in at Tour Eiffel."
        coordinates = {}
        coordinates[:latitude] = 48.858481766789
        coordinates[:longitude] = 2.2956111239207        
        #params[:picture] = "http://www.facebook.com/images/icons/place.png"  
        params[:place] = "141184112585566"  
        params[:coordinates] = ActiveSupport::JSON.encode(coordinates)
        
        #params[:id] = @user[:id]+"_"+cookies[:access_token]
        
        #params[:from] = {}
        #params[:from][:id] = @user[:id]
        #params[:from][:name] = @user[:name]
        #params[:location] = ActiveSupport::JSON.encode(location)
        #params[:description] = "Public"
        #params[:place][:id] = "141184112585566"
        #params[:privacy] = privacy
        #params[:place] = place
        #params[:message] = "checkin test 3"
        
        #tot = {:message => "checkin test 3", :privacy => privacy, :place => place}
        #puts "\n toto = "+tot.to_json
        #@user = MiniFB.get(cookies[:access_token], "me", :metadata=>true) 
 
        #MiniFB.rest(cookies[:access_token], "publish_checkins")
        #@fb = MiniFB::OAuthSession.new(cookies[:access_token], 'publish_checkins')
        
        puts "\n auth = #{MiniFB.scopes.to_json}\n "
        #MiniFB.call(@@fb_app_id, @@fb_secret, @user[:id], "publish_checkins")
        puts "\n params = #{params} \n "
 
        @res = MiniFB.post(cookies[:access_token], @user[:id], :type=>params[:type], :metadata=>true, :params => params)
      
        
        puts "\n res = #{@res}"
        #, :params => {:message => "checkin test 3", :place => "{\"id\": \"141184112585566\", \"name\" : \"Tour Eiffel\", \"location\" : {\"street\" : \"5, avenue Anatole France \u2013 Champ de Mars\", \"city\" : \"Paris\", \"country\" : \"France\", \"zip\" : \"75007\",\"latitude\" : \"48.858481766789\",\"longitude\" : \"2.2956111239207\"} }"})
        redirect_to :action=>"show", :id=>"me", :type=>"feed" 
  end

end
