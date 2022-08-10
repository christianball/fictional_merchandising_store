class Item < ApplicationRecord
  validates :code, presence: true,
                   length: {
                     minimum: 2,
                     maximum: 20
                   }

  validates :name, presence: true,
                   length: {
                     minimum: 2,
                     maximum: 50
                   }

  validates :price, presence: true,
                    numericality: {
                      greater_than_or_equal_to: 1,
                      less_than_or_equal_to: 9999999
                    }
end
