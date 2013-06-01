require 'we_the_people'
class PetitionsController < ApplicationController

  def show
    @id = params[:id]
    @petition = Petition.find(@id)

    respond_to do |format|
      format.html {
        @json = JSON.pretty_generate(@petition)
        @json_highlighted = CodeRay.scan(@json, :json).div
      }
      if params[:callback]
        format.js { render :json => @petition.to_json, :callback => params[:callback] }
      else
        format.json { render :json => @petition.to_json }
      end
    end
  end

  def index
    @issues = params[:issues] || []
    @statuses = params[:statuses] || []
    @signatures = params[:signatures].to_i
    @limit = params[:limit] || Petition::MAX_LIMIT
    @limit = @limit.to_i
    @collection = Petition.all(@issues, @statuses, @signatures, @limit)
    respond_to do |format|
      format.html
      if params[:callback]
        format.js { render :json => @collection.to_json, :callback => params[:callback] }
      else
        format.json { render :json => @collection.to_json }
      end
    end
  end

  private

  def class_from_sentiment(entity)
    case entity['sentiment_polarity']
      when 'negative'
        'error'
      when 'positive'
        'success'
      else
        ''
    end
  end
  helper_method :class_from_sentiment

end
