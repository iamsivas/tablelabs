Rails.application.routes.draw do
  root to: 'admin#index'

  get '/signin', to: 'users#sign_in'
  post '/signin', to: 'users#sign_in!'
  get '/signup', to: 'users#sign_up'
  post '/signup', to: 'users#sign_up!'
  get '/signout', to: 'users#signout'

  get '/cemp', to: 'users#check_empid'
  
  get '/careers', to: 'admin#view_all_career'
  get '/nc', to: 'admin#add_new_career'
  post '/create_career', to: 'admin#create_new_career'

  get '/ec/:id(.:format)', to: 'admin#edit_career'
  post '/uc/:id(.:format)', to: 'admin#update_career'
  get '/dc/:id(.:format)', to: 'admin#delete_career'

  get '/emps', to: 'admin#view_all_employees'
  get '/nemp', to: 'admin#new_employee'
  post '/newemp', to: 'admin#create_new_employee'
  get '/nepd/:id(.:format)', to: 'admin#emp_profile'
  post '/cepd/:id(.:format)', to: 'admin#create_employee_profile', as: 'create_emp_detail'
  get '/eepd/:id(.:format)', to: 'admin#edit_employee'
  post '/uepd/:id(.:format)', to: 'admin#update_employee_profile', as: 'update_emp_detail'
  get '/ve/:id(.:format)', to: 'admin#view_employee'
  get '/delemp', to: 'admin#delete_employee'
  get '/accdeact', to: 'admin#deactive_employee'
  get '/checkcont', to: 'admin#check_contact'
  get '/edu_qualify', to: 'admin#geteduaction'
  get '/check_pass', to: 'admin#check_password'
  get '/empws/:id', to: 'admin#employee_workstatus'

  get '/employee', to: 'employees#index'
  get '/accsts', to: 'employees#emp_account_status'
  get '/emp_pro', to: 'employees#emp_profile'
  get '/emp_log', to: 'employees#emp_log_details'

  get '/find_state', to: 'employees#state_list'
  get '/find_district', to: 'employees#district_list'
  get '/find_taluk', to: 'employees#taluk_list'
  get '/find_pincode', to: 'employees#pincode_list'
  get '/find_village', to: 'employees#village_list'
  get '/find_subcat', to: 'employees#subcatgory_list'
  get '/emp_data', to: 'employees#view_saved_file'
  get '/file/:id', to: 'employees#download_file'

  post '/add_addr', to: 'employees#create_new_address_text', as: 'addresstext'
  post '/add_rows', to: 'employees#create_new_address_rows', as: 'addressrows'
end
