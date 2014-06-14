require 'shortener'

module Shortener 	
	Shortener::ShortenedUrl.class_eval do	
	  	def self.set_url(old_url, new_url)
	    	url_in_store = Shortener::ShortenedUrl.find_by_url(clean_url(old_url))
		    if url_in_store
		    	url_in_store.url = new_url
		    else
		    	return nil
		    end
		    return url_in_store
	  	end

	  	def self.generate_with_auth(orig_url, auth_token, asset_id)
	  		result_url = Shortener::ShortenedUrl.generate!(orig_url)
	  		result_url.auth_token = auth_token
	  		result_url.asset_id = asset_id
	  		result_url.save
	  		return result_url
	  	end

	  	def self.delete_by_key(key)
		  	key_in_store = Shortener::ShortenedUrl.find_by_unique_key(key)
		  	if key_in_store
		  		key_in_store.delete!
		  		return true
		  	else
		  		return false
		  	end
	  	end
	end
end
