class Api::V1::CompaignsController < ApplicationController
    #skip_before_action :verify_authenticity_token

    def index
     return render :json => {:compaigns => Compaign.all}
    end
end