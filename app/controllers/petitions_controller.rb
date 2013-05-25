class PetitionsController < ApplicationController

  def show
    @id = params[:id]
    @petition = Petition.find(@id)

  end

end
