class Discussion < ApplicationRecord
  self.table_name = 'GDN_Discussion'
  self.primary_key = :DiscussionID

  belongs_to :category,   foreign_key: :CategoryID
  has_many   :comments,   foreign_key: :DiscussionID
  has_one    :creator,    class_name: 'User', primary_key: :InsertUserID, foreign_key: :UserID
  has_one    :last_user,  class_name: 'User', primary_key: :LastCommentUserID, foreign_key: :UserID

  scope :sorted, -> { order(Arel.sql("FIELD(Announce, 1, 2, 0), DateLastComment desc, DateInserted desc")) }
  scope :search, lambda { |term|
    where('match(Name, Body) against(?)', term)
  }
  scope :tagged, lambda { |tag|
    where('UPPER(Tags) like ?', "%#{tag.upcase}%")
  }

  alias_attribute :name,          :Name
  alias_attribute :body,          :Body
  alias_attribute :created,       :DateInserted
  alias_attribute :updated,       :DateUpdated
  alias_attribute :announce,      :Announce
  alias_attribute :closed,        :Closed
  alias_attribute :view_count,    :CountViews
  alias_attribute :comment_count, :CountComments
  alias_attribute :last_posted,   :DateLastComment
  alias_attribute :tags,          :Tags
  alias_attribute :format,        :Format

  def announcement?
    announce > 0
  end

  def closed?
    closed == 1
  end

  def tag_list
    tags.blank? and return []
    # sometimes tags are separated by commas, sometimes by spaces, sometimes
    # comma separated tags HAVE spaces. fun for the whole family.
    tag_list = []
    if tags =~ /,/
      tag_list = tags.split(',')
    else
      tag_list = tags.split(/\s/)
    end
    tag_list.collect{|t| t.squish}.reject{|t| t.blank?}
  end

end
