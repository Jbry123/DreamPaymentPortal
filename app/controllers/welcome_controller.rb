class WelcomeController < ApplicationController
  def index
    if request.fullpath == "/"
      cookies.delete :amount
      cookies.delete :campaign
    end
  end
end
