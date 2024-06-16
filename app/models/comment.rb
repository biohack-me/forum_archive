class Comment < ApplicationRecord
  self.table_name = 'GDN_Comment'
  self.primary_key = :CommentID

  belongs_to :discussion, foreign_key: :DiscussionID
  has_one    :creator,    class_name: 'User', primary_key: :InsertUserID, foreign_key: :UserID
  has_many   :attachments, -> { Attachment.active.comment }, foreign_key: :ForeignID

  scope :sorted, -> { order('DateInserted desc') }
  scope :search, lambda { |term|
    where('match(Body) against(?)', term).
    where('Body != ?', 'The user and all related content has been deleted.')
  }

  alias_attribute :body,    :Body
  alias_attribute :created, :DateInserted
  alias_attribute :updated, :DateUpdated
  alias_attribute :format,  :Format

end
