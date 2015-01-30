class CreatePorts < ActiveRecord::Migration
  def change
    create_table :ports do |t|
      t.string :name
      t.string :category
      t.string :code
      t.string :port_type
      t.integer :main_port_id
      t.string :country
      t.string :country_code
      t.float :additional_cahrges
      t.string :state
      t.timestamps
    end

    puts "Started importing ports..."
    bulk_data = []
    ancillary_ports = []
    xls = Roo::Spreadsheet.open("#{Rails.root}/db/ports.xlsx", extension: :xlsx)
    (2..xls.last_row).each do |i|
      line =  xls.row(i)
      ancillary_ports << [line[0], line[5]] if line[0] && line[5]
      bulk_data << Port.new(code: line[0], name: line[1], category: line[2], country_code: line[3], port_type: line[4], additional_cahrges: line[6])
    end
    Port.import bulk_data
    puts "Import finished!!! Updating main_port_id for ancillary port..."
    ## updating main_port_id for ancillary ports
    ancillary_ports.each do | ap |
      main_port = Port.where(code: ap[1]).first
      Port.where(code: ap[0]).first.update(:main_port_id => main_port.id)
    end
    puts "Finished importing ports !!!"      
  end
end