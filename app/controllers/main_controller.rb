class MainController < ApplicationController
  before_filter :authenticate_user!, only: [:index]

  def index
    render :index
  end

end
