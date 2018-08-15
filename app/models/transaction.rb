class Transaction < ApplicationRecord

  validates_presence_of :credit_card_number, :result

  belongs_to :invoice
  belongs_to :customer

end
