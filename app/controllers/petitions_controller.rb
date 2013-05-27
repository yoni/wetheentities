class PetitionsController < ApplicationController

  caches_page :show

  def show
    @id = params[:id]
    @petition = Petition.find(@id)

    respond_to do |format|
      format.html {
        pretty_json = JSON.pretty_generate(@petition)
        @json_highlighted = CodeRay.scan(pretty_json, :json).div
      }
      format.json {
        render :json => @petition.to_json
      }
    end
  end

end
