class Discussion < ApplicationRecord
  self.table_name = 'GDN_Discussion'
  self.primary_key = :DiscussionID

  belongs_to :category,    foreign_key: :CategoryID
  has_many   :comments,    -> {
    order('DateInserted asc')
  }, foreign_key: :DiscussionID
  has_one    :creator,     class_name: 'User', primary_key: :InsertUserID, foreign_key: :UserID
  has_one    :last_user,   class_name: 'User', primary_key: :LastCommentUserID, foreign_key: :UserID
  has_many   :attachments, -> { Attachment.active.discussion }, foreign_key: :ForeignID

  scope :sorted, -> { order(Arel.sql("FIELD(Announce,0) asc, DateLastComment desc, DateInserted desc")) }
  scope :search, lambda { |term|
    where('match(Name, Body) against(?)', term).
    where('Name != ?', 'The user and all related content has been deleted.').
    where('Body != ?', 'The user and all related content has been deleted.')
  }
  scope :tagged, lambda { |tag|
    where('UPPER(Tags) like ?', "%#{tag.upcase}%")
  }

  alias_attribute :name,            :Name
  alias_attribute :body,            :Body
  alias_attribute :created,         :DateInserted
  alias_attribute :updated,         :DateUpdated
  alias_attribute :announce,        :Announce
  alias_attribute :closed,          :Closed
  alias_attribute :view_count,      :CountViews
  alias_attribute :comment_count,   :CountComments
  alias_attribute :last_posted,     :DateLastComment
  alias_attribute :last_comment_id, :LastCommentID
  alias_attribute :tags,            :Tags
  alias_attribute :format,          :Format

  def announcement?
    announce > 0
  end

  def closed?
    closed == 1
  end

  def tag_list
    Rails.cache.fetch("discussion_#{id}_tags", expires_in: 12.hours) do
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

  # will return the number of pages will_paginate will break this discussion's
  # comments into
  def num_comment_pages
    Rails.cache.fetch("discussion_#{id}_num_pages", expires_in: 12.hours) do
      (comments.size/PER_PAGE_MAX.to_f).ceil
    end
  end

  # given a comment ID, will return the page number that comment will appear on
  # in this discussion's paginated comments
  def comment_page(comment_id)
    Rails.cache.fetch("comment_#{comment_id}_page", expires_in: 12.hours) do
      comment_ids = comments.collect(&:id)
      index = comment_ids.find_index(comment_id.to_i)
      index.blank? and return 1
      (index/PER_PAGE_MAX)+1
    end
  end

end
