class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :recoverable, :registerable, :rememberable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :trackable, :validatable

  field :name
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false}

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
