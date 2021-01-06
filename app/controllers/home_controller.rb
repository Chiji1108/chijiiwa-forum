class HomeController < ApplicationController
  def index
    @my_threads = MyThread.order(:updated_at).page(params[:page])
  end
end
