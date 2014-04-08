class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :facility

  validates :language, inclusion: { in: %w(english swahili, creole), message: 'For language, please select either "english" or "swahili"' }
end
