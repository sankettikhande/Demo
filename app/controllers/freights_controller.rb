class FreightsController < ApplicationController

  layout 'application'

  def search
    @freight_rates = Freight.search conditions: {source: params[:source], destination: params[:destination]}
    respond_to do |format |
      if current_user
        format.html
        format.js
      else
        format.html { redirect_to get_quotes_freights_path(search: params[:search]) }
      end
    end
  end

  def get_quotes
  end


end
