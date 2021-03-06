class UserCardSerializer < ActiveModel::Serializer
  attributes :user_id, :magic_card_id, :quality, :value, :quantity, :id, :magic_card_name, :magic_card

  belongs_to :user
  belongs_to :magic_card
  has_many :deck_cards, dependent: :destroy
  has_many :decks, through: :deck_cards

end
