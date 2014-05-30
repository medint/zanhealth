require 'RMagick'

namespace :test do
	desc "generate random qr codes"
	task :qr_code => :environment do
	
	im_width = 3.5
	im_height = 1.1
	dpi = 300
	pixel_width = (im_width * dpi).round
	pixel_height = (im_height * dpi).round

	background = Magick::Image.new(pixel_width, pixel_height)
	qrcode = Magick::Image.read('/home/jshum/Downloads/qrcode.png')[0]
	qrcode_large = qrcode.resize_to_fit(300,300)
	med_logo = Magick::Image.read('/home/jshum/Downloads/med-logo.png')[0]
	logo_large = med_logo.resize_to_fit(300,300)
	
	result = background.composite(qrcode_large,0,0, Magick::OverCompositeOp)
	result = result.composite(logo_large,320,20,Magick::OverCompositeOp)

	text = Magick::Draw.new
	text.annotate(result, 700, 500, 300,180,"UMM-001") {
		self.pointsize = 150
		self.font_weight = Magick::BoldWeight
		self.gravity = Magick::SouthGravity
	}
	
	result.write("output_qr.png")
	

	end
end
