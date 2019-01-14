# OTPspot #

Run a captive portal on your raspberry (or any linux box) to allow your guests to register before accessing your Wifi at home. Users will be requested for an OTP code that you can generate on your phone through the Google Authenticator/Authy app. 
Get rid of captive portal's static username and password, without the need for a complex radius server.

OTPspot (since version 2.0) is fully compatible with nodogsplash and can run as a FAS service. In this configuration, 
nodogsplash will take care of the networking whereas OTPspot will just authenticate the users.

*Project Home Page: https://github.com/user2684/otpspot*

## How to Run It ##
* On your phone, install Google Authenticator or Authy from the app store
* Create a local directory called `config` and map it into `/config` inside the container
* Run the image in interactive mode with `docker run --rm -ti -v $(pwd)/config:/config user2684/otpspot`. Since no Google Authenticator configuration file will be found, a new one will be created
* Scan the bar code on the screen to allow Google Authenticator on your phone to generate valid OTP codes. The same can be installed on multiple phones. Go through Google Authenticator configuration wizard; once it is finished, the container will exit
* Run the container again by mapping port 8000 with `docker run -p 8000:8000 -v $(pwd)/config:/config user2684/otpspot`; this time Google Authenticator configuration file will be found and OTPspot will be started
* You can optionally place a `config.py` file inside the `/config` directory to override any configuration setting (e.g. for the localisation of the captive portal)
* Configure nodogsplash to point to the captive portal running port 8000

## Tags ##
* [`latest`, `2.0`](https://github.com/user2684/otpspot-docker/blob/master/Dockerfile)

