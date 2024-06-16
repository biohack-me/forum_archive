class Attachment < ApplicationRecord

  # these are the mime types present in attachments when the forum was
  # archived, it is not an exhaustive list of possible or advisable attachment
  # types
  IMAGE_TYPES = ['image/png', 'image/jpeg', 'image/gif']
  DOC_TYPES = ['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/plain']

  self.table_name = 'GDN_Media'
  self.primary_key = :MediaID

  scope :active,     -> { where('Active = 1') }
  scope :discussion, -> { where("ForeignTable = 'discussion'") }
  scope :comment,    -> { where("ForeignTable = 'comment'") }
  scope :images,     -> { where('Type in (?)', IMAGE_TYPES) }
  scope :documents,  -> { where('Type in (?)', DOC_TYPES) }

  alias_attribute :name, :Name
  alias_attribute :type, :Type
  alias_attribute :size, :Size

  def is_image?
    IMAGE_TYPES.include?(type)
  end

  def is_document?
    DOC_TYPES.include?(type)
  end

  def path
    original_path = self.Path
    original_path.gsub(/editor\//, 'uploads/')
  end

  def thumb_path
    is_image? or return nil
    original_path = self.ThumbPath
    original_path.gsub(/editor\//, 'uploads/')
  end

end
