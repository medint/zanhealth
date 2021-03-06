#README#

[ ![Codeship Status for jshum/zanhealth](https://www.codeship.io/projects/8ae7f2a0-a264-0131-463c-7af97f1694a8/status?branch=master)](https://www.codeship.io/projects/18452)

##Overview

Zanhealth is an asset management webapp written using the Ruby on Rails framework. The purpose of the software is to track medical and facilities equipment through its lifecycle in order to minimize the downtime and financial output of operating the machines. 

The software tracks the equipment from the moment it arrives in the hospital to its eventual retirement. The software has import functionality that allows you to import inventory information in bulk. Throughout its lifecycle, a piece of equipment will often require repairs. Our software simplifies the process of receiving work repair requests from within the facility, and subsequently assigning them as work orders to other parties registered on the webapp. For each of these work orders, it provides tools to track time and cost output. The time and cost metrics are then translated into infographics on the dashboard which provide a bird's eye of the status of the inventory

The primary intended user of the webapp is the chief technician so we have tried to optimize the experience of assigning and the scheduling of work orders. However, the webapp always comes with different levels of permission which will allow larger facilities to operate more effectively.


###Ruby on Rails framework###

is a popular webapp framework for the Ruby language, wildly popular in the tech industry. It supports a wide variety of databases, environments and has an extensive collection of libraries that facilitate rapid development of webapps. During our development, our team has chosen Heroku as our preferred platform but many cloud hosting services provide integrations with Ruby on Rails.



##Installation##

####Install Ruby on Rails####



1. You can skip this part if you already have Ruby version >= 2.0.0. You can check this by typing ```ruby -v```
1. Install Git
	* If ```git``` doesn't result in command not found, then you can skip this step
	* Linux : ```sudo apt-get install git```
	* Mac OS X : should come installed with git
2. Install a ruby version controller. Either use rvm or rbenv. We have chosen rbenv in this tutorial
	* ```git clone https://github.com/sstephenson/rbenv.git ~/.rbenv```
	* Depending on what shell you use
		* ```echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc```
		* ```echo 'eval "$(rbenv init -)"' >> ~/.bashrc```
	*  restart your terminal (close it and reopen it or open a new tabe)
	*  ```type rbenv``` (make sure it says ```rbenv is a function```)
3. Install ruby build
	* ```git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build```
4. Install necessary packages for ruby
	* OS version dependent ```sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev```
9. Install a version of ruby. Zanhealth was developed using ruby 2.0.0
	* ```rbenv install 2.0.0```
	* ```rbenv global 2.0.0```
	* ```rbenv rehash```
12. make sure ```which gem``` and ```which ruby``` point to a path like the following ```/Users/johndoe/.rbenv/shims/ruby```
13. ```gem install bundler```
14. ```rbenv rehash```
15. ```which bundler``` make sure it points to the shims one eg. ```/Users/jshum/.rbenv/shims/bundle```


####Install Zanhealth using Postgres database####

The app uses Ruby on Rails, so the app uses the built-in gem activerecord for ORM. It is currently configured to use PostgreSQL as the SQL persistence store but you can choose to use other databases configurations if you wish. Edit `config/database.yml` for other settings

1. ```git clone https://github.com/medint/zanhealth.git```
  * enter in your github username and password if asked
3. ```cd zanhealth/```
4. Install PostgreSQL database
	* Unix
		* ```sudo apt-get install libpq-dev libsqlite3-dev nodejs ```
		* ```sudo apt-get install imagemagick libmagickwand-dev```
		* ```sudo apt-get install postgresql```
	* Mac
		* Install brew if you don't already have it
		* ```brew install postgresql```
		* Make sure to follow the instructions at the end of ```brew``` to
      launch postgresql (but the following two lines should be similar)
        * ```ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents```
      	* ```launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist```         
5. Create authorized medint user for zanhealth app to access database
	* Linux
    	* ```sudo su postgres``` (Change user to postgres)
    	* ```psql``` (this opens a postsql command line, the next commands are in this)
    	* Create medint
      		* ```create user medint with password 'password';```
      		* ```alter role medint createdb;```
      		* ```\q``` (this should get you out of the psql terminal)
  	* Mac
		* ```createuser -P -s -e medint```
		* Default password should be ```password``` by default 
	* Again, if you know what you're doing, you can configure `config/database.yml` to make your own changes
6. Make sure you have bundle installed and install all required gems
	* ``bundle install``
	* There might be some errors when you try to install the gems
		* Mac
			* There might be an error when you install the pg gem. One
        suggestion to fix it is ```ARCHFLAGS="-arch x86_64" gem install pg```
7. (Optional)
	* If you want to search functionality, you will need to install elasticsearch
	  * ```brew install elasticsearch``` if you are using Mac and homebrew
    * If you want to use the label generator, you will need to install
    imagemagick 
        * You will also have to uncomment out ```gem 'rmagick'``` in Gemfile and
      some lines in ```lib/tasks/qr_code.rake```
8. Open a terminal and navigate to the zanhealth folder ```cd zanhealth```
9. Create initial user.
	* It is advisable to open ```lib/tasks/initialize.rake``` in a text editor (for example use sublime and do ```subl lib/tasks/initialize.rake```) and change the line 23 and 25 to a new username and password for the admin user for security purposes)
	* ```./initialize.sh``` (initializes the database for zanhealth)

####Login for the first time####

1. Start app
	* ```./start_zanhealth.sh```
2. Open browser and go to ```localhost:3000```
3. Might be necessary to refresh since it takes sometime for app to load.
4. Press login button in the top right corner
5. The initialize script that you  creates a single user and facility
login with username ```admin```; password: ```adminpass``` (or whatever you changed it to in ```lib/tasks/initialize.rake```)
6. You should be logged in
7. As an admin user, you can navigate to ```localhost:3000/admin``` to get to the admin page. This is how you create new facilities and users for each facility

###Bugs and feature requests###

Have a bug or a feature request? Please first search for existing and closed issues. If your problem or idea is not addressed yet, please open a new issue.

###Contributing###

Please submit a pull request if you have a feature you want to add. Also
please don't hesitate to contact the medintl organization before you
start working on your feature so we can find ways to help you. 

###Resources###
 
* [MED International Official Website](http://medinternational-us.org)
* [Zanhealth](http://zanhealth.co) 
* [Zanhealth User Manual](http://medint.github.io/zanhealth-manual/)
