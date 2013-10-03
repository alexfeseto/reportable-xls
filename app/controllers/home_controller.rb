class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:index]

  def index
  end

  def about; end
  def contact; end

end
