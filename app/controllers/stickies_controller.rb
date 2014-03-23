class StickiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    stickies = current_user.stickies
    render json: stickies.to_json
  end

  def show
    id = params[:id]
    sticky = current_user.stickies.find(id)

    render json: sticky.to_json
  end

  def create
    sticky = current_user.stickies.create()

    render json: sticky.to_json
  end

  def update 
    id = params[:id]
    sticky = current_user.stickies.find(id)
    udpate_params = params[:sticky]
    sticky.update(update_params)

    render json: sticky.to_json
  end

  def destroy 
    sticky = current_user.stickies.find(params[:id])
    sticky.destroy

    render json: sticky.to_json
  end
  
end
