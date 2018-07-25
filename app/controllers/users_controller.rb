require 'socket'

class UsersController < ApplicationController
	skip_before_action :authenticate
  def sign_in
  end

  def check_empid
    puts params
    @user = User.where(:empid=>params[:empid])
    respond_to do |format|
      format.html { }
      format.json { render json: @user.count }
    end
  end

  def sign_in!
    @user = User.find_by(email: params[:email])
    if !@user
      flash[:error] = "This user doesn't exist"
      error = 1
    elsif !BCrypt::Password.new(@user.password_digest).is_password?(params[:password])
      flash[:error] = "Your password's wrong"
      error = 1
    elsif @user.current_status == 1
      flash[:error] = "Your account have already logged in"
      error = 1
    elsif @user.deactive == 1
      flash[:error] = 'Your account has been deactivated, please contact Admin'
      error = 1
    else
      flash[:success] = "You're signed in, #{@user.name}"
      error = 0
    end
    
    if error == 1
      redirect_to '/signin'
    elsif error == 0
      @user.current_status = 1
      @user.save
      session[:user] = @user

      if session[:user]["role"] == 1
        redirect_to '/'
      elsif session[:user]["role"] == 2
        @checklog = LoginMaster.where(empid: session[:user]['empid'], log_date: Date.today)
        if @checklog.count == 0
          log_master = LoginMaster.new(
            empid: @user.empid,
            ip_address: request.remote_ip,
            log_date: Date.today,
            login_time: Time.zone.now
          )
          log_master.save
        else
          log_master = LoginMaster.where(empid: @user.empid, log_date: Date.today).first
        end
        session[:logmaster] = log_master.id

        newlogin = EmpLoginwise.new
        newlogin.empid = session[:user]['empid']
        newlogin.date = Date.today
        newlogin.intime = Time.now
        newlogin.save
        session[:logid] = newlogin.id
      
        redirect_to '/employee'
      end
    end    
  end

  def sign_up
  end

  def sign_up!
    user = User.new(
    	name: params[:name],
      email: params[:email],
      password_digest: BCrypt::Password.create(params[:password])
    )
    if params[:password_confirmation] != params[:password]
      flash[:error] = "Your passwords don't match!"
      error = 1
    elsif user.save
      flash[:success] = "Your account has been created!"
      error = 0
    else
      flash[:error] = "Your account couldn't be created. Did you enter a unique username and password?"
      error = 1
    end
    if error = 1
      redirect_to '/signup'
    elsif error = 0
      redirect_to '/signin'
    end
  end

  def signout
    if session[:user]['role'] == 2
      @linec = EmpWorksheetCount.where(empid: session[:user]['empid'], create_at: Date.today)
      @line = []
      @page = []
      @linec.each do |co|
        @line.push(co.line_count)
        @page.push(co.page_count)
      end
      @linesum = @line.inject(0){|sum,x| sum + x }
      @pagesum = @page.inject(0){|sum,x| sum + x }

      @getintime = LoginMaster.find(session[:logmaster])
      @checkday = EmpDaywise.where(empid: session[:user]['empid'], date: Date.today).pluck(:id)
      if !@checkday.empty?
        @empday = EmpDaywise.where(id: @checkday).first
      else
        @empday = EmpDaywise.new()
      end
      @empday.empid = session[:user]['empid']
      @empday.date = Date.today
      @empday.max_hour = Time.now - @getintime.login_time
      @empday.line_count = @linesum
      @empday.page_count = @pagesum
      @empday.save
    end

    if session[:user]
      @user = User.find(session[:user]["id"])
      @user.current_status = 0
      @user.save
    end

    if session[:logmaster]
      logout = LoginMaster.find(session[:logmaster])
      logout.logout_time = Time.zone.now
      logout.save
    end

    if session[:logid]
      outtime = EmpLoginwise.find(session[:logid])
      outtime.outtime = Time.now
      outtime.save
    end
    flash[:success] = "You're signed out!"
    reset_session
    redirect_to root_url
  end
end
