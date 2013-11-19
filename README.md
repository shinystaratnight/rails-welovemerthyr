WE LOVE MERTHYR
---------------

Techniques
----------

- mongodb, mongoid
- rspec, factory_girl
- devise, cancan

Notes
-----

admin credentials: info@welovemerthyr.co.uk/welovemerthyr123

Rake tasks
----------

Available tasks:

  - `rake db:seed` : to create admin users
  - `rake db:import_businesses SEED=filename.csv` : to import businesses from db/seeds/filename.csv
  - `rake db:blank_to_closed`   : to make all 'blank' opening and closing times are set to 'closed'

FIXME
-----

- Business - User is 1 - 1, currently still can register a new user under a Business which already
  has 1 user.

Tire & Elastic search
---------------------

`rake environment tire:import CLASS=Business FORCE=true`
