Minifbclearance
=========

Rails authentication with facebook single sign-on OR email & password. 
Based on the gems Clearance by Thoughtbot and MiniFB by Appoxy

Help Request
----

I'm very new to rails, made the best I could! However, I'm sure it can be done better and cleaner, since I edited the clearance
gem manually to create this.  I'm sure this gem can be very useful and I'm just trying to contribute something to OpenSource! 

If you can Help drop me a line if you can help: pelaez89 {at} gmail {.} com

About
----
This gem has been created using Clearance and MiniFB gems, for more information referr to their source code, here:
* http://github.com/appoxy/mini_fb
* http://github.com/thoughtbot/clearance

I'm a Colombian design Student and pretty much a newbie in rails, this code works great and I'm using it in a soon to launch project.

I was concerned about security issues using only facebook JS single sign-on and wanted to use MiniFB (thanks guys
for such a great job) so that it could be use easily to authenticate users using their FB account, reducin sign-on/in times.

However regular email & password still works fine, so the clearance url's sign-on/in still work for those users not using FB.

Managing Login and Authentication
----

Authentication is managed through checking the cookie's token validity with Facebook API using an OAuth 2.0 connection, that 
means that even if the cookie with the user information hasn't been cleared from the browser, acces will be denied when 
such token  is no longer valid (aka the user sign-out of Facebook)

The gem doesn't use MiniFB oauth_url to login, instead it provides two helpers, facebook_js and facebook_login that
print inside your layout and inside your views the Fb login button and the JS required to point the users to the
Facebook controller inside the gem upon sign_in or session close. The facebook_js is required for the login button to work.

Installation
------------
Same as clearance 0.8.8 this works with versions of Rails greater than 2.3.

    gem install minifbclearance

Make sure the development database exists and run the generator. 

    script/generate minifbclearance

This:

* inserts Clearance::User into your User model
* inserts Clearance::Authentication into your ApplicationController
* inserts Clearance::Routes.draw(map) into your config.routes.rb
* created a migration that either creates a users table or adds only missing columns
* prints further instructions


Create your aplication in Facebook and set-up the information in config/facebook.yml (You'll have to create that file)

Facebook.yml
-----

You should create facebook.yml inside config folder, this is what it should look like.

:app_id: #Get this from http://www.facebook.com/developers/createapp.php
:secret: #from FB
:api_key: #from FB
:base_url: http://localhost:3000 #This is the url where you app's in, this is used to define where Fb should go after login
:after_login_path: /welcome/logged #Where to take your users when they login with FB
:after_register_path: /welcome/new #Where to go when a new user registers, use this to ask with a form for info specific to your app

Usage
-----

If you want to authenticate users for a controller action, use the authenticate
method in a before_filter.

      before_filter :authenticate

Known-issue with "Missing host to link to"
---------

Since Clearance tries to send confirmation mails and maybe Mailer settings are not defined in your app, you might run with and error. I'm not really sure why it happens but there's a solution if you just want to try clearance without the email confirmation.

Check this link for how I solved it. If this is some mistake of mine please tell me how to solve it and I'll just edit de code right away!

http://www.cherpec.com/2009/06/missing-host-to-link-to-please-provide-host-parameter-or-set-default_url_optionshost/

Other helpers
-----------
Note: I didn't have that much time to create some fancy and useful helper's, hopefully in a next version! 

The user Facebook pic url in square format is returned by the helper facebook_pic_url

Also the user name is added in a column inside user, so you can get that anytime with current_user.name

Using MiniFB
-----------
You might be interested in using Facebook API with your user, you can do that using MiniFB.
Facebook will create a cookie with the required information naming it fb_#{FB_APP_ID}_
you can retrieve that cookie and it's values a Hash using this helper 

parse_fb_cookie 

Customizing
-----------

I strongly suggest copying the views inside the gem to your views to customize them. 
Just copy the folder inside views, paste them in your app/views and customize it, 
Rails will load those views first before those specifies by the gem.

To change any of provided actions, subclass a Clearance controller. (See clearance doc for more details)

Thanks to
-------

* The Clearance team, seeeing the source code you have created I truly realize how professionally done and reliable this gem is. I'm sorry I had to cut some of your code but my knowledge until now in rails was not enough to keep it all, it just was over my current skills. It would be great if you take this into your code and begin to promote single-on cause that reduced a lot of friction to create conversions to a given web service and clearance is probably the most simple and complete authentication gem out there.
* Appoxy and all the MiniFB team, you really made a very simple solution to use Facebook, there's not so much documentation right now but the google group proves that there's a supporting community behind no matter the size. I'm working on some documentation and examples for not so experienced users to use MiniFB, I'll send them soon, maybe you could publish this somewhere to promote the gem plus the graph support is damn simple and clean!
* Ryan Bates from Railcasts, his tutorials have helped me a lot through my rails learning and he's banner "Give back to open source" is one of my biggest motivations to work in this project.


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
