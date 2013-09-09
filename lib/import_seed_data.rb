require 'csv'

# Import businesses from db/seeds/businesses.csv
#
def import_businesses
  file_path = Rails.root.join('db/seeds/businesses.csv')

  CSV.read(file_path, headers: true).each do |csv_row|
    new_row = csv_row.to_hash.except("Stamp").inject({}) do |row, (k, v)|
      row[k.downcase.parameterize.underscore.to_sym] = v if k.present?
      row
    end

    b = Business.new(new_row)

    b.save ?  print('.') : print('*')
  end
end
