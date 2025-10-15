class Tag < ApplicationRecord
  self.table_name = 'GDN_Tag'
  self.primary_key = :TagID

  alias_attribute :name, :Name
  alias_attribute :full_name, :FullName

  scope :by_name, lambda { |name|
    where('UPPER(Name) = ? or UPPER(FullName) = ?', name.upcase, name.upcase)
  }

end
