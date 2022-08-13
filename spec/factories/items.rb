# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    code { 'ITEM' }
    name  { 'Some item' }
    price { 19.99 }
  end
end
