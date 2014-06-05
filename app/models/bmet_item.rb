# == Schema Information
#
# Table name: bmet_items
#
#  id                :integer          not null, primary key
#  bmet_model_id     :integer
#  serial_number     :string(255)
#  year_manufactured :integer
#  funding           :string(255)
#  date_received     :date
#  warranty_expire   :date
#  contract_expire   :date
#  warranty_notes    :text
#  service_agent     :string(255)
#  department_id     :integer
#  created_at        :datetime
#  updated_at        :datetime
#  asset_id          :string(255)
#  item_type         :string(255)
#  location          :string(255)
#  status            :integer
#  condition         :integer
#  price             :decimal(5, 2)
#

class BmetItem < ActiveRecord::Base

  before_save :add_bmet_item_history
  belongs_to :bmet_model
  belongs_to :department
  has_many :bmet_work_orders
  has_many :bmet_item_histories

  def asset_model_location_name
    "#{asset_id} : #{bmet_model.name} at #{location}"
  end

  def add_bmet_item_history
    @original_bmet_item = BmetItem.find_by_id(self.id)
    if @original_bmet_item.try(:status) != self.status
      BmetItemHistory.create(
        :bmet_item_id => self.id,
        :bmet_item_status => self.status
      )
    end
    if @original_bmet_item.try(:condition) != self.condition
      BmetItemHistory.create(
        :bmet_item_id => self.id,
        :bmet_item_condition => self.condition
    )
    end
  end


  def self.import(file, facility_id)
    CSV.foreach(file.path, headers: true) do |row|
        matches = BmetItem.find_all_by_serial_number(row["serial_number"])
        if !matches
            item = BmetItem.new
            item.serial_number = row["serial_number"]
            item.year_manufactured = row["year_manufactured"]
            item.funding = row["funding"]
            item.date_received = row["date_received"]
            item.warranty_expire = row["warranty_expire"]
            item.warranty_notes = row["warranty_notes"]
            item.contract_expire = row["contract_expire"]
            item.service_agent = row["service_agent"]
            item.price = row["price"]
            item.asset_id = row["asset_id"]
            item.item_type = row["item_type"]
            item.location = row["location"]
            item.department = Department.find_by_name(row["department_name"])
            item.bmet_model = BmetModel.find_by_model_name(row["model_name"])
            item.save!
        else
          matches.each do |match|
            
            if BmetItem.where("match.department.facility_id = ?", facility_id)

            end
          end
        end
      end
    end

    def self.as_csv
      colnames = column_names.dup
      colnames.shift
      fullcolnames=colnames.dup
      colnames.shift
      colnames.delete_at(8)
      colnames << "department_name" << "manufacturer_name" << "model_name" <<"vendor_name"      
      CSV.generate do |csv|
          csv << colnames
          all.each do |item|              
              values = item.attributes.values_at(*fullcolnames)
              bmet_model=BmetModel.find(values[0])
              values.append(Department.find(values[9]).name)
              values.append(bmet_model.manufacturer_name)
              values.append(bmet_model.model_name)
              values.append(bmet_model.vendor_name)
              values.shift
              values.delete_at(8)
              csv << values
      end
    end
  end
end
