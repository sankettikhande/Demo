require 'csv'
class Freight < ActiveRecord::Base


  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  validates :source, :destination, :length, :height, :width, :min_weight, :freight_type, :max_weight, :transition_days, :price, :start_date, :end_date, :remark, :presence => true

  def self.imports(file)
    freights = []
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      freights << Freight.new(row_hash.merge(start_date: Date.parse(row_hash["start_date"]), end_date: Date.parse(row_hash["end_date"])))
    end
    Freight.import freights
  end

end
