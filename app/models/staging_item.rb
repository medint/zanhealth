class StagingItem < ActiveRecord::Base

	def self.get_matches(fac_id)
		attr_array = [
			'serial_number',
			'year_manufactured',
			'funding',
			'date_received',
			'warranty_expire',
			'warranty_notes',
			'contract_expire',
			'service_agent',
			'price',
			'asset_id',
			'item_type',
			'status',
			'condition',
			'location',
			'department_name',
			'short_url_key']
		items_array = []
		staging_items = StagingItem.where(:facility_id => fac_id )
		staging_items.each_with_index do |item, item_index|
			item_row = []
			attr_array.each do |attrib|
				item_row.push([item.send(attrib)])
			end
			match = BmetItem.where(:asset_id => item.asset_id).includes({ :department => :facility}).where("facilities.id=?",fac_id).references(:facility)[0]

			if match and match.department.facility_id == fac_id#Update existing records
				item_row.each_with_index do |cell, index|

					if attr_array[index] == 'department_name'
						if cell[0] == match.department.name
							self.push_unchanged(cell)
						elsif Department.where(:facility_id => fac_id).find_by_name(cell[0])
							self.push_changed(cell)
							cell[0] = match.department.name.to_s + " => " + cell[0].to_s
						else # Don't accept invalid department names, give an error
							self.push_errors(item_row)
							cell[0] = 'ERROR: Invalid department name ' + %q!"! + cell[0].to_s + %q!"!
						end

					elsif attr_array[index] == 'status'
						if cell[0].downcase == 'active' || cell[0].downcase == 'inactive' || cell[0].downcase == 'retired'
							status_string_hash = ['active','inactive','retired']
							if match.status and cell[0].downcase == status_string_hash[match.status]
								self.push_unchanged(cell)
							else
								self.push_changed(cell)
								if match.status
									cell[0] = status_string_hash[match.status].to_s.titlecase + "=>" + cell[0].to_s.titlecase
								end
							end
						else
							self.push_errors(item_row)
							cell[0] = 'ERROR: Invalid status ' + %q!"! + cell[0].to_s + %q!"!
						end

					elsif attr_array[index] == 'condition'
						cellval = cell[0].downcase
						if cellval == 'very good' || cellval == 'good' || cellval == 'fair' || cellval == 'poor'
							conditions_string_hash = ['poor','fair','good','very good']
							if match.condition and cellval == conditions_string_hash[match.condition]
								self.push_unchanged(cell)
							else
								self.push_changed(cell)
								if match.condition
									cell[0] = conditions_string_hash[match.condition].to_s.titlecase + "=>" + cell[0].to_s.titlecase
								end
							end
						else
							self.push_errors(item_row)
							cell[0] = 'ERROR: Invalid condition ' + %q!"! + cell[0].to_s + %q!"!
						end							

					else
						if cell[0] == match.send(attr_array[index])
							self.push_unchanged(cell)
						else
							self.push_changed(cell)
							cell[0] = match.send(attr_array[index]).to_s + " => " + cell[0].to_s
						end
					end

				end

			else #Create new non-existing records
				item_row.each_with_index do |cell, index|

					if attr_array[index] == 'department_name'
						if Department.where(:facility_id => fac_id).find_by_name(cell[0])
							self.push_changed(cell)
						else
							self.push_errors(item_row)
							cell[0] = 'ERROR: Invalid department name ' + %q!"! + cell[0].to_s + %q!"!
						end

					elsif attr_array[index] == 'status'
						if cell[0].downcase == 'active' || cell[0].downcase == 'inactive' || cell[0].downcase == 'retired'
							self.push_changed(cell)
						else
							self.push_errors(item_row)
							cell[0] = 'ERROR: Invalid status ' + %q!"! + cell[0].to_s + %q!"!
						end						

					elsif attr_array[index] == 'condition'
						cellval = cell[0].downcase
						if cellval == 'very good' || cellval == 'good' || cellval == 'fair' || cellval == 'poor'
							self.push_changed(cell)
						else
							self.push_errors(item_row)
							cell[0] = 'ERROR: Invalid condition ' + %q!"! + cell[0].to_s + %q!"!
						end				

					else
						self.push_changed(cell)
					end
				end
			end
			items_array.push(item_row)
		end
		return items_array
	end

	def self.push_changed(cell)
		if cell[1] and cell[1] != 'error'
			cell[1] = 'changed'
		elsif !cell[1]
			cell.push('changed')
		end
	end

	def self.push_unchanged(cell)
		if cell[1] and cell[1] != 'error'
			cell[1] = 'unchanged'
		elsif !cell[1]
			cell.push('unchanged')
		end
	end

	def self.push_errors(item_row)
		item_row.each do |cell|
			if cell[1]
				cell[1] = 'error'
			else
				cell.push('error')
			end
		end
	end
end