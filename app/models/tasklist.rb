class Tasklist < ApplicationRecord
  validates :status, presence: true, length: {maximum: 10}
end
