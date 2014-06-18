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

DATABASE
--------

Pull from Heroku:

- config heroku-mongo-sync plugin: https://github.com/marcofognog/heroku-mongo-sync:

```
  heroku plugins:install http://github.com/marcofognog/heroku-mongo-sync
```

- pull:

  `heroku mongo:pull`

Notice: `Heroku toolbelt` may not work and throws the error: `Install the Mongo gem to use mongo commands`, use `heroku`
gem instead then (`gem install heroku`)
