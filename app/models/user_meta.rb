class UserMeta < ApplicationRecord
  self.table_name = 'GDN_UserMeta'

  belongs_to :user,  foreign_key: :UserID

  alias_attribute :type,  :Name
  alias_attribute :value, :Value

  scope :type, lambda { |type|
    where(name: type)
  }
end
