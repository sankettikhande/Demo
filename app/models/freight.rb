require 'csv'
class Freight < ActiveRecord::Base


  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :source, class_name: 'Port', foreign_key: 'source_id'
  belongs_to :destination, class_name: 'Port', foreign_key: 'destination_id'

  validates :source_id, :destination_id, :length, :height, :width, :min_weight, :freight_type, :max_weight, :transition_days, :price, :start_date, :end_date, :remark, :presence => true
  class << self
    def imports(file)
      freights = []
      CSV.foreach(file.path, headers: true) do |row|
        row_hash = row.to_hash
        freights << Freight.new(row_hash.merge(start_date: Date.parse(row_hash["start_date"]), end_date: Date.parse(row_hash["end_date"])))
      end
      Freight.import freights
    end

    def manipulate_freight_data(params)
      freight_cal = params[:manipulate_val] if (params[:manipulate_val].present? && params[:manipulate_val]!= "Select")
      freight_data = params[:freight_data]
      freight_data.each do |key,val|
        freight = Freight.find(key)
        value = val.to_i
        if params[:change_val]== "constant_value"
          freight_price = freight_cal == "addition" ?  (freight.price + value) : (freight.price - value)
        elsif params[:change_val]== "change_by_percent"
          freight_price = freight_cal == "addition" ?  (freight.price + freight.price.to_f * (value/100).to_f) : (freight.price.to_f - (freight.price * value/100).to_f)
        end
        freight.update_attribute(:price, freight_price)
      end
    end

    def export(freights)
      CSV.generate do |csv|
        cols = ["From", "To", "L(Max)","W(Max)","H(Max)","Wt.From","Wt.To","Date From","Date To","Price","Freight Type","Transition Days"]
        csv << cols
        csv << []
        freights.each do |freight|
          csv <<[freight.source.port_name,freight.destination.port_name,freight.length, freight.width,freight.height,freight.min_weight,freight.max_weight,freight.start_date, freight.end_date,freight.price,freight.freight_type,freight.transition_days]
        end
      end
    end

    def to_csv(freights)
      CSV.generate do |csv|
        cols = ["seller", "From", "To", "Price", "Freight Type", "Transaction Days"]
        csv << cols
        csv << []
        freights.each do |freight|
          csv << [freight.seller.company_name,freight.source.port_name, freight.destination.port_name, freight.price, freight.freight_type, freight.transition_days]
        end
      end      
    end
  end

end




