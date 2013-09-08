WE LOVE MERTHYR
===============

Techniques
==========

* BrowserCMS
* PostgreSQL

Notes
=====

* CMS Admin:

  Navigate to http://welovemerthyr.herokuapp.com/cms

  We now have 3 users with credentials:
    - Site Admin  : admin/pass4test
    - Editor User : editor/pass4test
    - Guest User  : guest/pass4test

* Seed data:

  With a fresh db:
    - `rake db:setup`            : to install BCMS data and run all custom migrations.
    - `rake db:import_businesses`: to import businesses from db/seeds/businesses.csv into database.

TODO
====

- Get geolocation based on Address and Town combiantion.
- Add RSpec
