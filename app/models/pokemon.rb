class Pokemon < ApplicationRecord
  scope :captured, -> { where(captured: true) }
end
