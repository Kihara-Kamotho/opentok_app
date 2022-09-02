require "opentok"
class Room < ApplicationRecord 
  # create an opentok session 
  before_create :set_opentok_id 

  def set_opentok_id 
    opentok = OpenTok::OpenTok.new(ENV["api_key"], ENV["secret_key"], :role => :publisher ) # opentok client 
    session = opentok.create_session :media_mode => :routed # new opentok session 
    session_id = session.session_id # get session_id, this id is used to connect to a specific session
    self.vonage_session_id = session.session_id
  end 

end 