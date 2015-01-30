class Port < ActiveRecord::Base

	belongs_to :main_port, :class => Port
	has_many :ancillary_ports, :class => Port, :foreign_key => :main_port_id

	validates_presence_of :code, :name
	validates_uniqueness_of :code

	def port_name
		code + '('+ name + ')'
	end
end