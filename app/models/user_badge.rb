class UserBadge < ApplicationRecord
  self.table_name = 'GDN_BadgeAward'
  self.primary_key = :BadgeAwardID

  belongs_to :user,  foreign_key: :UserID
  belongs_to :badge, foreign_key: :BadgeID

  alias_attribute :created, :DateInserted

  scope :sorted, -> { order('DateInserted asc') }

end
