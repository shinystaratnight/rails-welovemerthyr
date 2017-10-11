namespace :carrierwave do
  task :recreate_business_images => :environment do
    Business.all.no_timeout.each do |ym| 
      begin
        #ym.process_your_uploader_upload = true # only if you use carrierwave_backgrounder
        ym.photo.cache_stored_file! 
        ym.photo.retrieve_from_cache!(ym.photo.cache_name) 
        ym.photo.recreate_versions!(:f_thumb, :f_small, :f_large) 
        ym.save! 
        puts ym.name
      rescue => e
        puts  "ERROR: Business: #{ym.id} -> #{e.to_s}"
      end
    end
  end
end
