class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :assignments, dependent: :destroy
  has_many :assigned_users, through: :assignments, source: :assigned_to
  has_many :reverse_assignments, class_name: 'Assignment', foreign_key: 'assigned_to_id', dependent: :destroy

  # Validations
  validates :email, format: { with: /\A.*@(?:rubyvision\.tech|chemicasoft\.com)\z/i, message: "must be from @rubyvision.tech or @chemicasoft.com domain" }
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }, allow_blank: true
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores" }, allow_blank: true

  # Methods
  def secret_santa_assignment
    assignments.secret_santa.first
  end

  def has_secret_santa_assignment?
    assignments.secret_santa.exists?
  end
end
