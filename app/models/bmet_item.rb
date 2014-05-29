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
#  price             :integer
#  created_at        :datetime
#  updated_at        :datetime
#  asset_id          :string(255)
#  item_type         :string(255)
#  location          :string(255)
#

class BmetItem < ActiveRecord::Base

  belongs_to :bmet_model
  belongs_to :department
  has_many :bmet_work_orders
  has_many :bmet_item_histories

  def self.import(file, facility_id)
    CSV.foreach(file.path, headers: true) do |row|
        match = BmetItem.find_by_serial_number(row["serial_number"])
        if !match || !BmetItem.where("match.department.facility_id = ?", facility_id)
          item = BmetItem.new
          item.serial_number = row["serial_number"]
          item.year_manufactured = row["year_manufactured"]
          item.funding = row["funding"]
          item.date_received = row["date_received"]
          item.warranty_expire = row["warranty_expire"]
          item.service_agent = row["service_agent"]
          item.department_id = Department.find_by_name(row["department_name"]).id
          item.price = row["price"]
          item.asset_id = row["asset_id"]
          item.item_type = row["item_type"]
          item.location = row["location"]
          item.department = Department.find_by_name(row["department_name"])
          item.bmet_model = BmetModel.find_by_model_name(row["model_name"])
          item.save!
        end
      end
    end

    def self.as_csv
      colnames = column_names.dup
      colnames.shift
      CSV.generate do |csv|
          csv << colnames
          all.each do |item|
              values = item.attributes.values_at(*colnames)
              values[0] = BmetModel.find(values[0]).name
              values[9] = Department.find(values[9]).name
              csv << values
      end
    end
  end
end
