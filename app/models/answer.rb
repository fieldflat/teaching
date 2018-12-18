class Answer < ApplicationRecord
  validates :user_id, {presence: true}
  validates :question_id, {presence: true}
  validates :content, {presence: true}
  mount_uploader :image_name, ImageNameUploader

  def user
    return User.find_by(id: self.user_id)
  end
end
