class FreightsController < ApplicationController

  layout 'application'

  def search
    @freight_rates = Freight.search conditions: {source: params[:source], destination: params[:destination]}
  end


end
