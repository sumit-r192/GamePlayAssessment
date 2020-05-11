# frozen_string_literal: true

class GameImageBucket < ApplicationRecord
  has_many_attached :images

  validates :images, presence: true, blob: { content_type: :image }
end
