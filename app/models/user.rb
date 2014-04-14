class User < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
  			:recoverable, :rememberable, :trackable, :validatable

	belongs_to :facility
	attr_accessor :login

	validates :username,:uniqueness => {:case_sensitive => false }
  	validates :language, inclusion: { in: %w(english swahili, creole), message: 'For language, please select either "english" or "swahili"' }

    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end

end
