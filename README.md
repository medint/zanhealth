#README#

[ ![Codeship Status for jshum/zanhealth](https://www.codeship.io/projects/8ae7f2a0-a264-0131-463c-7af97f1694a8/status?branch=master)](https://www.codeship.io/projects/18452)

###Install###
1) set up ruby on rails environment

2) clone this repo

3) Make initial admin user/facility and the roles. For security, edit lib/tasks/initialize.rake line25 to change the default password of the admin user (must be longer than 8 chars). To make the user/facility/roles, run ./initialize.sh

4) go to localhost:3000 to se home landing page

5) click the login button

6) login with the user that was just created (deault is username: admin; password: adminpass

7) now the application can be used normally; create work orders, requests, import, or log inventory.

8) as a admin user, you can navigate to localhost:3000/admin to get to the admin page. This is how you create new facilities and users for each facility

###Dependencies###

To run, please use >= ruby-2.0.0

Install elasticsearch using 'brew install elasticsearch' (Mac/Linux only) to make search bar work

`bundle install`

Other necessary packages

 
