class Wallet < ApplicationRecord
  belongs_to :user

  has_many :transactions

  STATUSES = {
    disabled: 0,
    enabled: 1
  }
end
