class PrayerRequestsController < ApplicationController
  def index
    render json: PrayerRequest.order(permitted_params[:order] => permitted_params[:direction]).page(index_params[:page]).per(index_params[:per])
  end

  def create
    PrayerRequest.new(requester_id: current_user.id, order: params[:order], direction: params[:direction]).save
  end

  private

  def index_params
    permitted = params.permit(:page, :per, :order, :direction)
    if permitted[:order].blank?
      permitted[:order] = 'created_at'
    end

    if permitted[:direction].blank?
      permitted[:direction] = 'desc'
    end

    if permitted[:page].blank?
      permitted[:page] = 1
    end

    if permitted[:per].blank?
      permitted[:per] = 25
    end

    permitted
  end
end