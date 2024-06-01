class Category < ApplicationRecord
  self.table_name = 'GDN_Category'
  self.primary_key = :CategoryID

  has_many :discussions, foreign_key: :CategoryID
  has_many :comments,    through: :discussions

  scope :top_level, -> { where(depth: 1) }
  scope :sorted, -> { order('sort asc') }

  alias_attribute :name,             :Name
  alias_attribute :description,      :Description
  alias_attribute :discussion_count, :CountAllDiscussions
  alias_attribute :comment_count,    :CountComments

end
