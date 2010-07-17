MiniFb-Clearance
=========

Rails authentication with facebook single sign-on OR email & password. 
Based on Clearance by Thoughtbot and Appoxy's MiniFB

Help Request
----

I'm very new to rails, made the best I could! However, I'm sure it can be done better and cleaner, since I edited the clearance
gem manually to create this.  
So if you can help I'm sure this gem can be very useful and I'm just trying to contribute something to OpenSource! 
Drop me a line if you can help: pelaez89 {at} gmail {.} com

About
----
This gem has been created using Clearance and MiniFB gems, for more information referr to their source code, here:
http://github.com/appoxy/mini_fb
http://github.com/thoughtbot/clearance

I'm a Colombian design Student and pretty much a newbie in rails, this code works and I'm using it in a soon to launch project.
I was concerned about security issues using only facebook JS single sign-on and wanted to simplify MiniFB(even more, thanks guys
for such a great job) so that it could be use easily to authenticate users using their FB account, reducin sign-on/in times.

However regular email & password still works fine, so the clearance url's sign-[*] still work for those users not using FB.

Managing Login and Authentication
----

Authentication is managed through checking the cookie's token validity with Facebook API using an OAuth 2.0 connection, that 
means that even if the cookie with the user information hasn't been cleared from the browser, acces will be denied when 
such token  is no longer valid (aka the user sign-out of Facebook)

The gem doesn't use MiniFB oauth_url to login, instead it provides two helpers, facebook_js and facebook_login that
print inside your layout and inside your views the Fb login button and the JS required to point the users to the
Facebook controller inside the gem upon sign_in or session close. The facebook_js is required for the login button to work.

Installation#CHEK THIS
------------
Same as clearance 0.8.8 this works with versions of Rails greater than 2.3.

    gem "minifbclearance"

Make sure the development database exists and run the generator. 

    script/generate minifbclearance

This:

* Generates the facebook.yml to config your app inside /config
* inserts Clearance::User into your User model
* inserts Clearance::Authentication into your ApplicationController
* inserts Clearance::Routes.draw(map) into your config.routes.rb
* created a migration that either creates a users table or adds only missing columns
* prints further instructions

Usage
-----

If you want to authenticate users for a controller action, use the authenticate
method in a before_filter.

      before_filter :authenticate

Other helpers
-----------
Note: I didn't have that much time to create some fancy and useful helper's, hopefully in a next version! 

The user Facebook pic url in square format is returned by the helper facebook_pic_url

Alo the user name is added in a column inside user, so you can get that anytime

Using MiniFB
-----------
You might be interested in using Facebook API with your user, you can do that using MiniFB.
Facebook will create a cookie with the required information using this form fb_#{FB_APP_ID}_
you can retrieve that cookie and it's values a a Hasg using this helper 

parse_fb_cookie 

That helper's defined when the gem loads

Customizing
-----------

I strongly suggest copying the view inside the gem to your views to customize them. 
Just copy the folder inside views, paste them in your app/views and customize it, 
Rails will load those views first.

To change any of provided actions, subclass a Clearance controller. (See clearance doc for more details)


MiniFb Authors
-------

Appoxy: http://www.appoxy.com/

Clerance Authors
-------

Clearance was extracted out of [Hoptoad](http://hoptoadapp.com). We merged the
authentication code from two of thoughtbot client Rails apps and have since
used it each time we need authentication.

The following people have improved the library. Thank you!

Dan Croak, Mike Burns, Jason Morrison, Joe Ferris, Eugene Bolshakov,
Nick Quaranto, Josh Nichols, Mike Breen, Marcel Görner, Bence Nagy, Ben Mabey,
Eloy Duran, Tim Pope, Mihai Anca, Mark Cornick, Shay Arnett, Joshua Clayton,
Mustafa Ekim, Jon Yurek, Anuj Dutta, Chad Pytel, Ben Orenstein, Bobby Wilson,
Matthew Ford, Ryan McGeary, Claudio Poli, Joseph Holsten, and Peter Haza.
