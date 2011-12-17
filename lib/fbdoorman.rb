require 'mini_fb'
require 'facebook_helpers'
require 'request_parser'

require 'clearance/extensions/errors'
require 'clearance/extensions/rescue'
require 'clearance/configuration'
require 'clearance/routes'
require 'clearance/authentication'
require 'clearance/user'


#Load the configuration for miniFB
FB = YAML.load_file("#{RAILS_ROOT}/config/facebook.yml")
#Set the value in constants for easy use
FB_API_KEY = FB[:api_key]
FB_APP_ID = FB[:app_id]
FB_SECRET = FB[:secret]
MAILER_SENDER = FB[:mailer_sender]

#This routed will be name with clearance routes as /facebook
FB_CALLBACK_URL = "#{FB[:base_url]}/facebook"
#This routed will be name with clearance routes as /facebookclosed
FB_CLOSED_URL = "#{FB[:base_url]}/fbclosed"

LOGGED_PATH = FB[:after_login_path]

URL_AFTER_CREATE = FB[:url_after_create]

