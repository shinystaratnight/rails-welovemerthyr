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

  We now have 3 users:
    - Site Admin with credentials: admin/pass4test
    - Editor User with credentials: editor/pass4test
    - Guest User with credentials: guest/pass4test

* Seed data:

  Businesses: `rake db:import_businesses` will import businesses data from db/seeds/businesses.csv into database.

TODO
====

- Get geolocation based on Address and Town combiantion.
- Add RSpec
