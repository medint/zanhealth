#README#

[ ![Codeship Status for jshum/zanhealth](https://www.codeship.io/projects/8ae7f2a0-a264-0131-463c-7af97f1694a8/status?branch=master)](https://www.codeship.io/projects/18452)

###Install###

####Install ruby on rails####
(type all these commands into the terminal)
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

sudo apt-get install git

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

echo 'eval "$(rbenv init -)"' >> ~/.bashrc

restart your terminal (close it and reopen it or open a new tabe)

type rbenv
make sure it says rbenv is a function

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

rbenv install 2.1.5

rbenv global 2.1.5

rbenv rehash

make sure which gem and which ruby point to the shims one

gem install bundler

rbenv rehash

which bundler make sure it points to the shims one


####Install Zanhealth using postgres database####
git clone https://github.com/medint/zanhealth.git
enter in your github username and password

cd zanhealth/

sudo apt-get install libpq-dev libsqlite3-dev nodejs 

sudo apt-get install imagemagick libmagickwand-dev

bundle install

sudo apt-get install postgresql

sudo su postgres

psql (this opens a postsql command line, the next commands are in this)

create user medint with password 'password';

alter role medint createdb;

\q (this should get you out of the psql terminal)

open a new terminal window

get to the zanhealth folder (cd zanhealth)

(it is advisable to open lib/tasks/initialize.rake in a text editor (for example use sublime and do 'subl lib/tasks/initialize.rake') and change the line 23 and 25 to a new username and password for the admin user for security purposes)

./initialize.sh (makes the database)

./start_zanhealth.sh

####loging in the first time####

open browser and go to 
localhost:3000

if it doesnt work, refresh

press login in the top right

the initialize creates a single user and facility
login with username admin; password adminpass (or whatever you changed it to)

and you are ready to use the app

as a admin user, you can navigate to localhost:3000/admin to get to the admin page. This is how you create new facilities and users for each facility

###Dependencies###

To run, please use >= ruby-2.0.0

Install elasticsearch using 'brew install elasticsearch' (Mac/Linux only) to make search bar work

`bundle install`

Other necessary packages

 
