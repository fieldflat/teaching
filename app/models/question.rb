class Question < ApplicationRecord
  validates :user_id, {presence: true}
  validates :title, {presence: true, length: { maximum: 75 }}
  validates :content, {presence: true, length: { maximum: 400 }}
  mount_uploader :image_name, QuestionImageNameUploader

  def user
    return User.find_by(id: self.user_id)
  end
end
