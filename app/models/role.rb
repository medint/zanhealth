class Role < ActiveRecord::Base
    has_many :users
    
    def to_sym
        self.name.to_sym
    end
end
