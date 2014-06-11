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
