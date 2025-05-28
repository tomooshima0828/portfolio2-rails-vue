class Project < ApplicationRecord
  has_one_attached :image
  has_many :project_technologies, dependent: :destroy
  has_many :technologies, through: :project_technologies

  def image_url
    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) if image.attached?
  end
end
