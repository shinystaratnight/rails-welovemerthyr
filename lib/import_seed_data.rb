require 'csv'

# Import businesses from db/seeds/businesses.csv
#
def import_businesses
  file_path = Rails.root.join('db/seeds/businesses.csv')

  CSV.read(file_path, headers: true).each do |csv_row|
    weekly_schedule = {}

    new_row = csv_row.to_hash.except("Stamp").inject({}) do |row, (k, v)|
      if k.present? && !k.downcase.ends_with?("opening") && !k.downcase.ends_with?("closing")
        if k != 'Services'
          row[k.downcase.to_sym] = v
        else
          row[:service_list] = v
        end
      elsif k.present? && (k.downcase.ends_with?("opening") || k.downcase.ends_with?("closing"))
        weekly_schedule[k.downcase.parameterize.underscore] = v
      end

      row
    end

    b = Business.new(new_row)

    if b.save
      b.create_weekly_schedule!(weekly_schedule)
    else
      print '*'
    end

    print '.'
  end
end
