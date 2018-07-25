module EmployeesHelper
	def address_1(name, address, phone, website, landmark, empid, pincode)
		@exist1 = AddressMaster.where(name: name, pincode: pincode)
		if @exist1.count == 0
			new_address(name, address, phone, website, landmark, empid, pincode)
		else
			return @address_1 = name
		end
	end

	def new_address(name, address, phone, website, landmark, empid, pincode)
		new_address = AddressMaster.new()
		new_address.empid = empid
		new_address.create_date = Date.today
		new_address.name = name
		new_address.address = address
		new_address.landmark = landmark
		new_address.phone_no = phone
		new_address.website = website
		new_address.pincode = pincode
		new_address.save
	end
end
