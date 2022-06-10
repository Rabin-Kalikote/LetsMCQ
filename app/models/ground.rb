class Ground < ApplicationRecord
  validates :name, uniqueness: true
  has_many :ground_players, dependent: :destroy
  has_many :users, through: :ground_players

  enum prep: [:plus_two, :ioe, :iom]
  # enum status: [:joining, :playing, :over]

  def to_param
    self.name
  end

  def organizer
    self.ground_players.where(is_organizer: true).first.user
  end
end
