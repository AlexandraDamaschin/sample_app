class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user&.authentificated?(:activation, params[:id])
    else

    end
  end
end
