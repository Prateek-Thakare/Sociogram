class PublicController < ApplicationController
    before_action :check_sign_in
    layout 'homepage'
    def homepage

    end
    def check_sign_in
        redirect_to dashboard_path if signed_in?
    end
end
