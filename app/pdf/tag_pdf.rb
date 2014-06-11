require 'RMagick'
require 'rqrcode_png'
require 'shortener'
require 'chunky_png/rmagick'
require 'prawn'

class TagPdf < Prawn::Document

	def initialize(start_num, end_num, asset_id_prefix)
		im_width = 3.5
		im_height = 1.1
		generate_image_tags(start_num,end_num,asset_id_prefix)

		custom_pdf_size = [im_width * 72, im_height * 72] # pt is 1/72 of inch
		super(:page_size => custom_pdf_size,
			:page_layout => :portrait,
			:margin => [0,0,0,0])
		for i in start_num..end_num
			unless i == start_num
				start_new_page(:size => custom_pdf_size, :page_layout => :portrait)
			end
			image "output_qr_#{i}.png", :width => im_width * 72
		end
	end

	def generate_image_tags(start_num,end_num,asset_id_prefix)
		
		dummy_charset = ('a'..'z').to_a + (0..9).to_a
		im_width = 3.5
		im_height = 1.1
		dpi = 300      	
      	num_sig_figs = 3

		for i in start_num..end_num
		
			dummy_url_key = (0...5).map{ dummy_charset[rand(dummy_charset.size)] }.join    
			dummy_url_base = "http://test.com"	    
			result_url = Shortener::ShortenedUrl.generate!(dummy_url_base+dummy_url_key)
			qr_code_url = "http://zanhealth.co/qr/" + result_url.unique_key
			puts qr_code_url


			pixel_width = (im_width * dpi).round
			pixel_height = (im_height * dpi).round

			background = Magick::Image.new(pixel_width, pixel_height)

			qr = RQRCode::QRCode.new( qr_code_url, :size => 4, :level => :h )
	      	qr_png = qr.to_img.resize(300,300)
	      	qr_png.save('qr_image.png')
			qrcode = ChunkyPNG::RMagick.export(qr_png)  # returns an instance of ChunkyPNG
						
			#qrcode = Magick::Image.read('/home/jshum/Downloads/qrcode.png')[0]
			qrcode_large = qrcode.resize_to_fit(300,300)
			med_logo = Magick::Image.read('app/assets/images/logo.png')[0]
			logo_large = med_logo.resize_to_fit(300,300)
			
			result = background.composite(qrcode_large,20,20, Magick::OverCompositeOp)
			result = result.composite(logo_large,370,20,Magick::OverCompositeOp)

			asset_text = Magick::Draw.new
			pad_zeros = "0"*(num_sig_figs - i.to_s.length)

			asset_text.annotate(result, 700, 200, 350,250,"#{asset_id_prefix}-#{pad_zeros}#{i.to_s}") {
				self.pointsize = 130
				self.font_weight = Magick::BoldWeight
				self.font_family = 'helvetica'
			}
			
			qr_code_url_text = Magick::Draw.new
			#draw.annotate(img, width, height, x, y, text) [ { additional parameters } ] -> self
			qr_code_url_text.annotate(result, 800, 400, 350,300, qr_code_url) {
				self.pointsize = 30
				self.font_weight = Magick::BoldWeight
				self.font_family = 'helvetica'
			}	

			result.write("output_qr_#{i}.png")

		end
	end
end