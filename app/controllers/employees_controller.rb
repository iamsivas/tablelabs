class EmployeesController < ApplicationController
  before_action :set_cache_buster

  require 'fileutils'
  require 'socket'
  include EmployeesHelper

  def index
  	@countries = CountryMaster.all.order('country_name asc')
    @maincats = CategoryMaster.where(:parent_id=>0).order('cat_name asc')
    @address = AddressMaster.new
  end

  def state_list
    @states = StateMaster.where(:country_id => params[:country]).order('state_name asc')
    respond_to do |format|
      format.html 
      format.json { render json: @states }
    end
  end

  def district_list
    @districts = DistrictMaster.where(:state_id => params[:state]).order('district_name asc')
    respond_to do |format|
      format.html 
      format.json { render json: @districts }
    end
  end

  def taluk_list
    @taluks = TalukMaster.where(:district_id => params[:district]).order('taluk_name asc')
    respond_to do |format|
      format.html 
      format.json { render json: @taluks }
    end
  end

  def pincode_list
    @codes = PincodeMaster.where(:taluk_id => params[:taluk]).order('pincode asc')
    respond_to do |format|
      format.html 
      format.json { render json: @codes }
    end
  end

  def village_list
    @village = VillageMaster.where(:pincode_id => params[:pin], :taluk_id => params[:talid]).order('village_name asc')
    respond_to do |format|
      format.html 
      format.json { render json: @village }
    end
  end

  def subcatgory_list
    @subcat = CategoryMaster.where(:parent_id=>params[:catid]).order('cat_name asc')
    respond_to do |format|
      format.html
      format.json{render json:@subcat }
    end
  end

  def create_new_address_text
    @checkarea = VillageMaster.where(:country_id=>params[:country], :state_id=>params[:state], :district_id=>params[:district], :taluk_id=>params[:taluk], :pincode_id=>params[:pincode], :id=>params[:village])
    if @checkarea.count != 0
      check = 1
    else
      check = 0
    end

    if check == 1
      empid = session[:user]['empid']
      date = Date.today.strftime('%d_%m_%Y')
      country = CountryMaster.find(params[:country]).country_name
      state = StateMaster.find(params[:state]).state_name
      district = DistrictMaster.find(params[:district]).district_name
      taluk = TalukMaster.find(params[:taluk]).taluk_name
      pincode = PincodeMaster.find(params[:pincode]).pincode
      village = VillageMaster.find(params[:village]).village_name
      maincat = CategoryMaster.find(params[:maincat]).cat_name
      if params[:subcat]
        subcat = CategoryMaster.find(params[:subcat]).cat_name
        @filedir = "#{Rails.root}/storage/#{empid}/#{date}/#{country}/#{state}/#{district}/#{taluk}/#{pincode}/#{village}/#{maincat}/#{subcat}"
      else
        @filedir = "#{Rails.root}/storage/#{empid}/#{date}/#{country}/#{state}/#{district}/#{taluk}/#{pincode}/#{village}/#{maincat}"
      end
      if Dir.exists?(@filedir)
        @getcount = Dir["#{@filedir}/*.txt"]
        @filename = "#{village}.txt"
        @pagecount = @getcount.size
        exist = 1
      else
        maindir = FileUtils.mkdir_p(@filedir)
        @filename = "#{village}.txt"
        @pagecount = 1
        exist = 0
      end

      @file = File.new("#{@filedir}/#{@filename}", "a")
      if @file
        @file.syswrite("#{params[:address]}\n")
      else
        flash[:error] = 'Unable to open file'
      end

      if exist == 0
        newpath = EmpFilepath.new()
      else
        newpath = EmpFilepath.find_by(file_name:@filename)
      end
      newpath.empid = session[:user]['empid']
      newpath.logid = session[:logid]
      newpath.file_path = File.dirname(@file)
      newpath.file_name = File.basename(@file)
      newpath.create_date = Date.today
      if newpath.save
        filename = "#{newpath.file_path}/#{newpath.file_name}"
        linecount = `wc -l "#{filename}"`.strip.split(' ')[0].to_i
        
        @exist = EmpWorksheetCount.where(empid: session[:user]['empid'], logid:session[:logid], fileid: newpath.id, create_at: Date.today).pluck(:id)
        if !@exist.empty?
          workcount = EmpWorksheetCount.where(id: @exist).last
        else
          workcount = EmpWorksheetCount.new
        end
        workcount.empid = session[:user]['empid']
        workcount.fileid = newpath.id
        workcount.catid = params[:maincat]
        workcount.logid = session[:logid]
        workcount.line_count = linecount
        workcount.page_count = @pagecount
        workcount.create_at = Date.today
        workcount.save

        flash[:success] = 'Data has been saved successfully'
        redirect_to '/employee'
      else
      end
    end
  end

  def create_new_address_rows
    @error = []
    if params[:name_1]
      address_1(params[:name_1], params[:address_1], params[:phone_1], params[:website_1], params[:landmark_1], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_2]
      address_1(params[:name_2], params[:address_2], params[:phone_2], params[:website_2], params[:landmark_2], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_3]
      address_1(params[:name_3], params[:address_3], params[:phone_3], params[:website_3], params[:landmark_3], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_4]
      address_1(params[:name_4], params[:address_4], params[:phone_4], params[:website_4], params[:landmark_4], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_5]
      address_1(params[:name_5], params[:address_5], params[:phone_5], params[:website_5], params[:landmark_5], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_6]
      address_1(params[:name_6], params[:address_6], params[:phone_6], params[:website_6], params[:landmark_6], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_7]
      address_1(params[:name_7], params[:address_7], params[:phone_7], params[:website_7], params[:landmark_7], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_8]
      address_1(params[:name_8], params[:address_8], params[:phone_8], params[:website_8], params[:landmark_8], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_9]
      address_1(params[:name_9], params[:address_9], params[:phone_9], params[:website_9], params[:landmark_9], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end

    if params[:name_10]
      address_1(params[:name_10], params[:address_10], params[:phone_10], params[:website_10], params[:landmark_10], session[:user]['empid'], params[:pincode])
      @error.push(@address_1)
    end
    
    if @error.size != 0
      flash[:error] = "#{@error.join(', ')} are already exists"
    else
      flash[:success] = "Data are saved successfully"
    end
    redirect_to '/employee'
  end

  def emp_profile
  	@emp = EmployeeProfile.find_by(:userid=>session[:user]["id"])
  	@empq = QualificationMaster.find(@emp.qualification).name
  	@empd = DepartmentMaster.find(@emp.department).name
  end

  def view_saved_file
    @files = EmpFilepath.where(empid: session[:user]['empid'])
  end

  def download_file
    @file = EmpFilepath.find(params[:id])
    @location = @file.file_path + "/" + @file.file_name

    response.headers.delete("Pragma")
    response.headers.delete('Cache-Control')

    send_file(@location,
      :filename     => @file.file_name,
      :disposition  =>  'attachment',
      :streaming    =>  'true',
      :type         =>  'application/octet-stream'
    )
  end

  def emp_log_details
  end

  def emp_account_status
  	@user = User.find(session[:user]["id"])
  end

  def set_cache_buster
     response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
     response.headers["Pragma"] = "no-cache"
     response.headers["Expires"] = "0"
   end
end
