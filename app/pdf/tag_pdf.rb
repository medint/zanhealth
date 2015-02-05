require 'RMagick'
require 'rqrcode_png'
require 'shortener'
require 'chunky_png/rmagick'
require 'prawn'

# @author jshum
class TagPdf < Prawn::Document

	# Returns a pdf file with custom labels
	def initialize(start_num, end_num, asset_id_prefix,auth_token)
		im_width = 3.5 # inches
		im_height = 1.1 # inches
		generate_image_tags(start_num,end_num,asset_id_prefix,auth_token)

		custom_pdf_size = [im_width * 72, im_height * 72] # pt is 1/72 of inch
		super(:page_size => custom_pdf_size,
			:page_layout => :portrait,
			:margin => [0,0,0,0])
		for i in start_num..end_num
			unless i == start_num
				# super method that generates a new page based on size
				start_new_page(:size => custom_pdf_size, :page_layout => :portrait)
			end
			# loads image onto the page
			image "output_qr_#{i}.png", :width => im_width * 72
		end
	end

	def generate_image_tags(start_num,end_num,asset_id_prefix,auth_token)
		
		dummy_charset = ('a'..'z').to_a + (0..9).to_a
		im_width = 3.5
		im_height = 1.1
		dpi = 300      	
      	num_sig_figs = 3

		for i in start_num..end_num
			
			# 1. Generate all the necessary text, url and asset_id
			pad_zeros = "0"*(num_sig_figs - i.to_s.length)
			# Asset string for label
			asset_string = "#{asset_id_prefix}-#{pad_zeros}#{i.to_s}"
			# generate unique dummy key			
			dummy_url_key = (0...5).map{ dummy_charset[rand(dummy_charset.size)] }.join    
			dummy_url_base = "http://test.com"	    
			# While loop that determines that unique key is in fact unique
			while(Shortener::ShortenedUrl.find_by_url(dummy_url_base+dummy_url_key))
				dummy_url_key = (0...5).map{ dummy_charset[rand(dummy_charset.size)] }.join    
				dummy_url_base = "http://test.com"	    
			end

			result_url = Shortener::ShortenedUrl.generate_with_auth(dummy_url_base+dummy_url_key, auth_token,asset_string)
			qr_code_url = "http://zanhealth.co/qr/" + result_url.unique_key

			# 2. Start creating the image
			pixel_width = (im_width * dpi).round
			pixel_height = (im_height * dpi).round

			background = Magick::Image.new(pixel_width, pixel_height)

			# 3. Generate the Qr code as an image
			qr = RQRCode::QRCode.new( qr_code_url, :size => 4, :level => :h )
	      	qr_png = qr.to_img.resize(300,300)
	      	qr_png.save('qr_image.png')
			qrcode = ChunkyPNG::RMagick.export(qr_png)  # returns an instance of ChunkyPNG
						
			#qrcode = Magick::Image.read('/home/jshum/Downloads/qrcode.png')[0]
			qrcode_large = qrcode.resize_to_fit(300,300)

			# 4. Generate the logo
			med_logo = Magick::Image.read('app/assets/images/logo.png')[0]
			logo_large = med_logo.resize_to_fit(300,300)
			
			# 5. Put all the composite images together
			result = background.composite(qrcode_large,20,20, Magick::OverCompositeOp)
			result = result.composite(logo_large,370,20,Magick::OverCompositeOp)

			asset_text = Magick::Draw.new
			
			# 6. Add text to the composite image
			asset_text.annotate(result, 700, 200, 350,250,asset_string) {
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

			# 7. Output to local file system. This is volatile, should upload to S3 instead
			result.write("output_qr_#{i}.png")

		end
	end
end