class Badge < ApplicationRecord
  self.table_name = 'GDN_Badge'
  self.primary_key = :BadgeID

  has_many   :user_badges, foreign_key: :BadgeID
  has_many   :users,       through: :user_badges

  alias_attribute :name,        :Name
  alias_attribute :photo,       :Photo
  alias_attribute :description, :Description

  # the path for the badge 'Photo' in the vanilla database can't map directly
  # to a rails path, but that's easy enough to fix
  def image_path
    photo.sub('/applications/yaga/design/images/', 'badges/')
  end

end
