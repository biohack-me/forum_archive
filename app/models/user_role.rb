class UserRole < ApplicationRecord
  self.table_name = 'GDN_UserRole'

  belongs_to :user, foreign_key: :UserID
  belongs_to :role, foreign_key: :RoleID
end
