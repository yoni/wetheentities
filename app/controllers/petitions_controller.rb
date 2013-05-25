class PetitionsController < ApplicationController

  caches_page :show

  def show
    @id = params[:id]
    @petition = Petition.find(@id)

    respond_to do |format|
      format.html
      format.json{
        render :json => @petition.to_json
      }
    end

  end

end
