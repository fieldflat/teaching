class Question < ApplicationRecord
  validates :user_id, {presence: true}
  validates :title, {presence: true}
  validates :content, {presence: true}
  mount_uploader :image_name, QuestionImageNameUploader

  def user
    return User.find_by(id: self.user_id)
  end
end
