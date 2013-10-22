namespace :db do
 desc 'generate sample data for Posts, Vouchers, Events, import Businesses...'
 task give_me_everthing_dude: :environment do
   return unless Rails.env.development?

   Rake::Task['db:drop'].invoke
   Rake::Task['db:create'].invoke
   Rake::Task['db:seed'].invoke
   ENV['SEED'] = 'businesses.csv'
   Rake::Task['db:import_businesses'].invoke
   ENV['SEED'] = 'businesses_2.csv'
   Rake::Task['db:import_businesses'].invoke

   puts 'Creating users, posts, deals, events...'
   50.times do
     User.create(email: Faker::Internet.email, password: 'merthyr123', password_confirmation: 'merthyr123')
     Post.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
     Deal.create(title: Faker::Lorem.sentence, business_id: Business.all.map(&:id).sample)
     Event.create(name: Faker::Lorem.sentence(word_count=2), starts: (rand(50) - 20).days.from_now)
   end

   puts 'Done.'
 end
end