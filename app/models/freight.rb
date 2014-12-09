require 'csv'
class Freight < ActiveRecord::Base

  def self.imports(file)
    freights = []
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      freights << Freight.new(row_hash.merge(start_date: Date.parse(row_hash["start_date"]), end_date: Date.parse(row_hash["end_date"])))
    end
    Freight.import freights
  end
end
