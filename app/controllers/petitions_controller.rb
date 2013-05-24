class PetitionsController < ApplicationController

  def show
    @id = params[:id]
    petition_analysis = Petition.find(@id)
    @open_calais = petition_analysis[:open_calais]
    @semantria = petition_analysis[:semantria]
  end

end
