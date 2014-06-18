# == Schema Information
#
# Table name: staging_models
#
#  id                :integer          not null, primary key
#  model_name        :string(255)
#  manufacturer_name :string(255)
#  vendor_name       :string(255)
#  facility_id       :integer
#  item_group        :string(255)
#

class StagingModel < ActiveRecord::Base

	def self.get_matches(fac_id)
		models_array = []
		staging_models = StagingModel.where(:facility_id => fac_id)
		staging_models.each do |model|
			model_row = [[model.model_name], [model.manufacturer_name], [model.vendor_name], [model.category], [model.item_group]]
			match = BmetModel.where(:facility_id => fac_id).where("LOWER(model_name) =?", model.model_name).where("LOWER(manufacturer_name) =?", model.manufacturer_name).where("LOWER(vendor_name) =?", model.vendor_name).where("LOWER(category) =?", model.category)[0]
			if match
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
