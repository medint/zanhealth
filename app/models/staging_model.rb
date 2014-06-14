class StagingModel < ActiveRecord::Base

	def self.get_matches(fac_id)
		models_array = []
		staging_models = StagingModel.where(:facility_id => fac_id)
		staging_models.each do |model|
			model_row = [[model.model_name], [model.manufacturer_name], [model.vendor_name], [model.item_group]]
			matches = BmetModel.where("model_name = ?", model.model_name)
			hasMatch = false
			matches.each do |match|
				if match.manufacturer_name == model.manufacturer_name and match.vendor_name == model.vendor_name and match.facility_id == fac_id and match.item_group.name.downcase == model.item_group.downcase
					hasMatch = true
				end
			end
			if hasMatch
				model_row.each do |cell|
					cell.push('unchanged')
				end
			else
				model_row.each do |cell|
					if cell[0] == model.item_group
						if ItemGroup.find_by_name(cell[0])
							cell.push('changed')
						else
							cell[0] = 'ERROR: Invalid item group ' + %q!"! + cell[0].to_s + %q!"!
							self.push_errors(model_row)
						end
					else
						cell.push('changed')
					end
				end
			end
			models_array.push(model_row)
		end
		return models_array
	end

	def self.push_errors(model_row)
		model_row.each do |cell|
			if cell[1]
				cell[1] = 'error'
			else
				cell.push('error')
			end
		end
	end

end