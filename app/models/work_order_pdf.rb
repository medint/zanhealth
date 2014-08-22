
class WorkOrderPdf < Prawn::Document
	def initialize(wo)
		super(top_margin: 50, left_margin: 40, right_margin: 40, bottom_margin: 30)
		@wo = wo
		@item = wo.bmet_item
    @status= ['Active', 'Inactive', 'Retired']
    @conditions = ['Poor', 'Fair', 'Good', 'Very Good']

		header
		work_order_details
    move_down 10
    item_details
    move_down 10
    labor_hours
    move_down 10
    costs
    move_down 10
    comments

	end

	def header
		left = bounds.left - 40
    right = bounds.right + 40
    full_width = bounds.width + 80
    bounding_box [left, bounds.top + 35], width: full_width, height: 60 do      
      font "Helvetica"
      fill_color "000000"
      text @wo.requester.facility.name, align: :center, size: 20, style: :bold
      fill_color "555555"
      text "Work Order " + @wo.id.to_s, align: :center, size: 14, inline_format: :true, style: :bold
		end
  end

  def work_order_details
  	font "Helvetica"
  	fill_color "555555"
  	text "Work Order Details", align: :center, size: 10, style: :bold
  	fill_color "000000"
  	table([
  		["Item", @item.bmet_model.name],
  		["Description", @wo.description],
  		["Date Started", @wo.date_requested.try(:strftime,"%d %b %Y")],
  		["Expected Date of Completion", @wo.date_expire.try(:strftime,"%d %b %Y")],
  		["Completion Date", @wo.date_completed.try(:strftime,"%d %b %Y")],
  		["Requester", @wo.requester.name],
  		["Owner", @wo.owner.name],
  		["Department", @wo.department.name],
  		["Location", @item.location]
		], :position => :center,
      :column_widths => [150, 380],
      :cell_style => {:font => "Helvetica", :size => 10}
    )

  end

  def item_details
    font "Helvetica"
    fill_color "555555"
    text "Item Details", align: :center, size: 10, style: :bold
    fill_color "000000"
    table([
      ["Status", @status[@item.status]],
      ["Condition", @conditions[@item.condition]],
      ["Date Purchased", @item.date_received.try(:strftime,"%d %b %Y")],
      ["Price", @item.price],
      ["Asset ID", @item.asset_id],
      ["Serial Number", @item.serial_number],
      ["Contract Expiration", @item.contract_expire.try(:strftime,"%d %b %Y")],
      ["Warranty Expiration", @item.warranty_expire.try(:strftime,"%d %b %Y")],
      ["Warranty Notes", @item.warranty_notes],
      ["Misc. Notes", @item.notes]
      ], :position => :center,
        :column_widths => [150, 380],
        :cell_style => {:font => "Helvetica", :size => 10}
      )
  end

  def labor_hours
    font "Helvetica"
    fill_color "555555"
    text "Hours Log", align: :center, size: 12, style: :bold
    fill_color "000000"
    table([
      ["Worked By", "Date", "Clock in", "Clock out", "Labor time", "Down time"],
      ["","","","","",""],
      ["","","","","",""],
      ["","","","","",""],
      ["","","","","",""]
      ], :header => true,
        :position => :center,
        :column_widths => [187, 79, 79, 79, 53, 53],
        :cell_style => {:font => "Helvetica", :size => 12, :height => 35, :align => :center}
      )
  end

  def costs
    font "Helvetica"
    fill_color "555555"
    text "Costs Log", align: :center, size: 12, style: :bold
    fill_color "000000"
    table([
      ["Consumable/Part name", "Individual price", "Quantity", "Total"],
      ["","","",""],
      ["","","",""],
      ["","","",""],
      ["","","",""]
      ], :header => true,
        :position => :center,
        :column_widths => [212, 106, 106, 106],
        :cell_style => {:font => "Helvetica", :size => 12, :height => 35, :align => :center}
      )
  end

  def comments
    table([
      ["Additional comments/details"],
      ["                                                                                  
                                                                                






                                                                                    "]
      ], :position => :center,
        :width => bounds.width,
        :cell_style => {:font => "Helvetica", :size => 12, :align => :center}
    )
  end

end