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
			'location',
			'department_name']
		items_array = []
		staging_items = StagingItem.where(:facility_id => fac_id )
		staging_items.each_with_index do |item, item_index|
			item_row = []
			attr_array.each do |attrib|
				item_row.push([item.send(attrib)])
			end
			match = BmetItem.find_by_asset_id(item.asset_id)
			if match and match.department.facility_id == fac_id#Update existing records
				item_row.each_with_index do |cell, index|

					if attr_array[index] == 'department_name'
						if cell[0] == match.department.name
							cell.push('unchanged')
						elsif Department.where(:facility_id => fac_id).find_by_name(cell[0])
							cell.push('changed')
							cell[0] = match.department.name.to_s + " => " + cell[0].to_s
						else
							cell.push('error')# Don't accept invalid department names, give an error
							item_row.each do |c|
								c[1] = 'error'
							end
						end

					else
						if cell[0] == match.send(attr_array[index])
							cell.push('unchanged')
						else
							cell.push('changed')
							cell[0] = match.send(attr_array[index]).to_s + " => " + cell[0].to_s
						end
					end

				end
			else#Create new non-existing records
				item_row.each_with_index do |cell, index|

					if attr_array[index] == 'department_name'
						if Department.where(:facility_id => fac_id).find_by_name(cell[0])
							cell.push('changed')
						else
							cell.push('error')
							item_row.each do |c|
								c[1] = 'error'
							end
						end

					else
						cell.push('changed')
					end
				end
			end
			items_array.push(item_row)
		end
		return items_array
	end

end