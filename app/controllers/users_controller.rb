class UsersController < ApplicationController
  load_and_authorize_resource

  before_filter :require_login

  def index
    @users = User.find(:all)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created User. #{params[:user].to_s}"
      redirect_to users_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    store_location
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated User."
      redirect_back_to root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to root_path unless can? :manage, User
      redirect_to users_path
    end
  end

  def check_user
  end

  private

    def redirect_back_to(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def store_location
      session[:return_to] = request.headers["HTTP_REFERER"]
    end

end
