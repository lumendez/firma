class Users::MultiFactorAuthenticationController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def verify_enable
    #if current_user == @user &&
       #current_user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
    if @user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
       #current_user.otp_module_enabled!
       @user.otp_module_enabled!
       redirect_to users_path, notice: 'Autenticación de dos factores habilitada'
    else
      redirect_to users_path, alert: 'La autenticación de dos factores no puede ser habilitada'
    end
  end

  def verify_disabled
    #if current_user == @user &&
       #current_user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
    if @user.authenticate_otp(params[:multi_factor_authentication][:otp_code_token], drift: 60)
       #current_user.otp_module_disabled!
       @user.otp_module_disabled!
       redirect_to users_path, notice: 'Autenticación de dos factores desabilitada'
    else
      redirect_to users_path, alert: 'La autenticación de dos factores no puede ser desabilitada'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
