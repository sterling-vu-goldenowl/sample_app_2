# frozen_string_literal: true

class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if !user.activated? && user&.authenticate?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to user, notice: 'Account activated!'
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_path
    end
  end
end
