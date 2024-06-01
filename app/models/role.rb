class Role < ApplicationRecord
  self.table_name = 'GDN_Role'
  self.primary_key = :RoleID

  has_many   :user_roles, foreign_key: :RoleID
  has_many   :users,      through: :user_roles

  alias_attribute :name,  :Name
end
