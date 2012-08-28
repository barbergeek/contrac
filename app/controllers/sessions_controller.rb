class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      if @user = User.find_by_email(params[:email])
        if !@user.sso && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          format.html { redirect_back_or_to(:root, :success => 'Login successful.') }
          format.xml { render :xml => @user, :status => :created, :location => @user }
        #elsif @user.sso && pop3_authenticate(params[:email],params[:password])
        else
          format.html { flash.now.alert = "Login failed."; render :action => "new" }
          format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      else
        format.html { flash.now.alert = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice: 'Logged out!'
  end

end
