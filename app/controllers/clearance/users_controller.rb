class Clearance::UsersController < ApplicationController
  unloadable

  skip_before_filter :authenticate, :only => [:new, :create]
  before_filter :redirect_to_root,  :only => [:new, :create], :if => :signed_in?
  filter_parameter_logging :password

  def new
    @user = ::User.new(params[:user])
    render :template => 'users/new'
  end

  #Here the email login users are created, FB user creation is managed in the fb controller
  def create
    @user = ::User.new params[:user]
    if @user.save
      flash_notice_after_create
      sign_in(@user) #Login recently created user
      redirect_to(url_after_create)
    else
      flash_failure_after_create
      render :template => 'users/new'
    end
  end

  private

  def flash_notice_after_create
    flash[:notice] = translate(:deliver_confirmation,
      :scope   => [:clearance, :controllers, :users],
      :default => "You will receive an email within the next few minutes. " <<
                  "It contains instructions for confirming your account.")
  end
  
  def flash_failure_after_create
    flash.now[:failure] = translate(:used_email_or_unmatching_passwords,
      :scope   => [:clearance, :controllers, :users],
      :default => "Email is already being used or the passwords didn't match.")
  end

  def url_after_create
    sign_in_url
  end
end
