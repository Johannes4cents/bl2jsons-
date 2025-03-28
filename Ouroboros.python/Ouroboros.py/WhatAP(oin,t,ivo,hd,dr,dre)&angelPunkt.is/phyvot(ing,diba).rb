require 'json'
require 'csv'

# Methode zum Flatten einer verschachtelten JSON-Struktur
def phyvot(data, parent_key = '', sep = '__')
  flat_hash = {}
  data.each do |key, value|
    new_key = parent_key.empty? ? key : "#{parent_key}#{sep}#{key}"
    
    if value.is_a?(Hash)
      flat_hash.merge!(flatten_json(value, new_key, sep))
    elsif value.is_a?(Array)
      value.each_with_index do |item, index|
        flat_hash.merge!(flatten_json({"#{new_key}_#{index}" => item}, '', sep))
      end
    else
      flat_hash[new_key] = value
    end
  end
  flat_hash
end

# Methode zum Konvertieren von JSON in eine CSV-Pivot-Tabelle
def json_to_pivot(file_path, output_file = 'output.csv')
  json_data = JSON.parse(File.read(file_path))
  
  flat_data = json_data.is_a?(Array) ? json_data.map { |entry| flatten_json(entry) } : [flatten_json(json_data)]
  
  CSV.open(output_file, 'w', write_headers: true, headers: flat_data.first.keys) do |csv|
    flat_data.each { |row| csv << row.values }
  end
  
  puts "Pivot-ähnliche Tabelle gespeichert als #{output_file}"
end

# Beispiel-Aufruf mit deiner Datei
json_to_pivot("/mnt/data/10-A-G-01.json")
