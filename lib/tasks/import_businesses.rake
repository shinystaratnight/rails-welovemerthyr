require 'import_seed_data'

namespace :db do
  desc 'import businesses from CSV'
  task import_businesses: :environment do
    print 'Importing busineses ...'

    import_businesses

    puts
    puts 'Imported.'
  end
end
