BillShare is my first personal rails app! It was designed to replace using a
spreadsheet to split up my phone bill.

In essence it is a CRM. After signing up you can create bills and charges, track 
balances, mark charges as paid, and email your plan members so they know what to 
pay. Reviewing past bills is easy with individualized graphs on the member pages 
and the homepage.

* Ruby version: 2.3.0p0

* System dependencies: Bootstrap

After you have the repository cloned, run "bundle install" to install the gemfile.

Then you can create and seed the database by running "rake db:create", 
  "rake db:migrate", "rake db:seed". This will create an account you can use to
  login right away and view the sample data. Fire up your local server and login!
  
  The login is "user@example.com" and the password is "password".

* How to run the test suite: rspec