class Photo < ApplicationRecord

  has_many :recipes

  mount_uploader :filename, PhotoUploader

  delegate :url, to: :filename

  after_initialize :generate_id

private

  def generate_id
    self.id ||= SecureRandom.uuid
  end

end
