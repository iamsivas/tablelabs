require 'time'
class AdminController < ApplicationController
  def index
  	@contacts = Contact.where(:status=>0)
  	@careers = CareerApplied.where(:profile_status=>0)
  	@employees = User.where(:role=>2)
  end

  def view_all_employees
  	@employees = User.where(:role=>2)
  end

  def new_employee
  	@newemp = User.new
  end

  def check_password
    @user = User.find_by(:id=>1)
    if BCrypt::Password.new(@user.password_digest).is_password?(params[:password])
      @value = 1
    else
      @value = 0
    end
    respond_to do |format|
      format.html 
      format.json { render json: @value }
    end
  end

  def create_new_employee
  	newemp = User.new(
  		name: params[:name].capitalize,
      email: params[:email],
      empid: params[:empid],
      role: 2,
      password_digest: BCrypt::Password.create(params[:password])
  	)
  	if params[:password_confirmation] != params[:password]
  		flash[:error] = "Your passwords don't match"
  		error = 1
  	elsif newemp.save
  		flash[:info] = 'Please fill employee details to create an account'
  		error = 0
  	else
  		flash[:info] = "Your account couldn't be created. Did you enter a unique username and password?"
  		error = 1
  	end
  	if error == 1
  		redirect_to '/nemp'
  	elsif error == 0
  		redirect_to "/nepd/#{newemp.id}"
  	end
  end

  def emp_profile
  	@qualies = QualificationMaster.all.order('name')
  	@departs = DepartmentMaster.all.order('name')
  end

  def geteduaction
    @qualies = QualificationMaster.where("name like '#{params[:findedu]}%'").order('name')
    respond_to do |format|
      format.html 
      format.json { render json: @qualies }
    end
  end

  def create_employee_profile
  	emp_detail = EmployeeProfile.new(
  		userid: params[:id],
  		door_no: params[:door_no],
  		street: params[:street].capitalize,
  		village: params[:post],
  		city: params[:city].capitalize,
  		pincode: params[:pincode],
  		qualification: params[:degree],
  		experience: params[:expri],
  		department: params[:dept],
  		phone_no: params[:mobile],
  		birth_date: params[:birth],
  		bank_acc_no: params[:accno],
  		bank_ifsc: params[:ifsc].upcase,
  	)
  	if emp_detail.save
  		flash[:success] = 'Employee account has been created successfully'
  		redirect_to '/emps'
  	end
  end

  def view_employee
  	@emp = User.find(params[:id])
  	@empdetail = EmployeeProfile.find_by(:userid=>params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_employee
  	@emps = EmployeeProfile.find_by(:userid=>params[:id])
  	@qualies = QualificationMaster.all.order('name')
  	@departs = DepartmentMaster.all.order('name')
  end

  def update_employee_profile
  	@update = EmployeeProfile.find_by(:userid=>params[:id])
  	@update.door_no = params[:door_no]
  	@update.street = params[:street].capitalize
  	@update.village = params[:post]
  	@update.city = params[:city].capitalize
  	@update.pincode = params[:pincode]
  	@update.qualification = params[:degree]
  	@update.experience = params[:expri]
  	@update.department = params[:dept]
  	@update.phone_no = params[:mobile]
  	@update.birth_date = params[:birth]
  	@update.bank_acc_no = params[:accno]
  	@update.bank_ifsc = params[:ifsc].upcase
  	@update.save

  	if @update.save
  		flash[:success] = 'Details have been updated successfully'
  		redirect_to :controller=>'admin', :action=>'view_all_employees'
  	end
  end

  def delete_employee
  	User.find(params[:id]).destroy
  	respond_to do |format|
      format.html { }
      format.json { render json: 1 }
    end
  end

  def deactive_employee
  	@user = User.find(params[:id])
  	@user.deactive = params[:status]
  	@user.save

  	respond_to do |format|
  		format.html { }
  		format.json { render json: @user.deactive }
  	end
  end

  def view_all_career
  	@careers = Career.all
  end

  def create_new_career
  	add_career = Career.new(
  		name: params[:name],
  		description: params[:description],
  		skills: params[:skill],
  		created_at: Date.today
  	)
  	if add_career.save
  		flash[:success] = 'New position created successfully'
  		redirect_to '/careers'
  	end
  end

  def edit_career
  	#@current_name = "Admin"
  	@editc = Career.find(params[:id])
  end

  def update_career
  	update_career = Career.find(params[:id])
  	update_career.name = params[:name]
  	update_career.description = params[:description]
  	update_career.skills = params[:skill]
  	update_career.created_at = Date.today
  	update_career.save

  	if update_career.save
  		flash[:success] = 'Position updated successfully'
  		redirect_to '/careers'
  	end
  end

  def delete_career
  	Career.find(params[:id]).destroy
  	flash[:info] = 'Position has been deleted successfully'
  	redirect_to '/careers'
  end

  def employee_workstatus
    @user = User.find(params[:id])
  	@logwise = EmpLoginwise.where(:empid=>@user.empid)
    @daywise = EmpDaywise.where(:empid=>@user.empid)
    @monthwise = EmpDaywise.where(:empid=>@user.empid).group_by { |m| m.date.beginning_of_month }
    puts "-------------12121----------",@monthwise.count
  end
end
