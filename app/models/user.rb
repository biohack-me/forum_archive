class User < ApplicationRecord
  self.table_name = 'GDN_User'
  self.primary_key = :UserID

  has_many   :discussions, foreign_key: :InsertUserID
  has_many   :comments,    foreign_key: :InsertUserID
  has_many   :user_badges, foreign_key: :UserID
  has_many   :badges,      through: :user_badges
  has_many   :user_roles,  foreign_key: :UserID
  has_many   :roles,       through: :user_roles
  has_many   :user_meta,   class_name: 'UserMeta', foreign_key: :UserID

  scope :find_by_username, lambda { |name|
    where('UPPER(Name) like ?', "%#{name.upcase}%").
    where('Name != ?', '[Deleted User]').
    order('Name asc')
  }
  scope :active,           -> { where('deleted != 1') }
  scope :profile_metadata, -> { includes(:roles, :user_meta, user_badges: [:badge], discussions: [:category, :creator, :last_user, :comments], comments: [:creator, discussion: [:category]]) }
  scope :with_discussions, -> { includes(discussions: [:category, :creator, :last_user, :comments]) }
  scope :with_comments,    -> { includes(comments: [:creator, discussion: [:category]]) }

  alias_attribute :name,            :Name
  alias_attribute :photo,           :Photo
  alias_attribute :email,           :Email
  alias_attribute :about,           :About
  alias_attribute :created,         :DateInserted
  alias_attribute :visit_count,     :CountVisits
  alias_attribute :last_active,     :DateLastActive
  alias_attribute :points,          :Points
  alias_attribute :show_email,      :ShowEmail
  alias_attribute :raw_attributes,  :Attributes
  alias_attribute :raw_preferences, :Preferences
  alias_attribute :deleted,         :Deleted

  def photo_url(size = 'small')
    Rails.cache.fetch("user_#{id}_photo_#{size}", expires_in: 12.hours) do
      # avatars uploaded to vanilla will be stored in GDN_User.photo as,
      #   'userpics/F2IH2KPW2RWL/GBH6RG50OK5K.png'
      # but this will expand to several files, like:
      #   userpics/F2IH2KPW2RWL/nGBH6RG50OK5K.png PNG 40x40 40x40+0+0 8-bit sRGB 4240B 0.000u 0:00.001
      #   userpics/F2IH2KPW2RWL/pGBH6RG50OK5K.png PNG 250x250 250x250+0+0 8-bit sRGB 116627B 0.000u 0:00.000
      # sometimes these are directly under userpics/, sometimes there is an
      # intermediary directory
      # if 'size' requested is 'small' (the default), prepend 'n' to the image
      # filename, otherwise prepent 'p'
      if (photo =~ /\Auserpics\//)
        prefix = (size == 'small') ? 'n' : 'p'
        photo.gsub(/\/(\w+\.[A-z]{3,4})\z/, "/#{prefix}"+'\1')

      # if the photo is to an external URL, it will work or it won't
      elsif (photo =~ /\Ahttps?:\/\//)
        photo

      # if there is no photo, or if the photo is something unexpected
      # (not in userpics/ and not an external URL), try gravatar, falling back to
      # a DiceBear Bottts avatar using the email hash as a seed
      else
        email_hash = Digest::MD5.hexdigest(email.downcase)
        dicebear_fallback = ERB::Util.url_encode("https://api.dicebear.com/8.x/bottts/png/seed=#{email_hash}")
        gravatar_size = (size == 'small') ? '40' : '200'
        "https://gravatar.com/avatar/#{email_hash}?s=#{gravatar_size}&d=#{dicebear_fallback}"
      end
    end
  end

  def show_email?
    show_email == 1
  end

  def private?
    Rails.cache.fetch("user_#{id}_private", expires_in: 12.hours) do
      attributes.is_a?(Hash) or return false
      attributes['Private'] == '1'
    end
  end

  def deleted?
    Rails.cache.fetch("user_#{id}_deleted", expires_in: 12.hours) do
      deleted == 1
    end
  end

  def pronouns
    user_pronouns = user_meta.type('Profile.Pronouns').first
    user_pronouns ? user_pronouns.value : ''
  end

  def skills
    user_skills = user_meta.type('Profile.Skills').first
    user_skills ? user_skills.value : ''
  end

  private

  # vanilla stores random JSON data in a few text fields - parse them in case
  # something in there is needed
  # parse_json() is defined in ApplicationRecord
  def attributes
    parse_json(raw_attributes)
  end
  def preferences
    parse_json(raw_preferences)
  end

end
