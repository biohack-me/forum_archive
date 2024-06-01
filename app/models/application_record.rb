class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private

  # vanilla likes to store JSON data in text fields. also, sometimes that data
  # isn't even valid JSON, so fail gracefully in that case
  def parse_json(attribute)
    attribute.blank? and return nil
    begin
      JSON.parse attribute
    rescue JSON::ParserError
      nil
    end
  end

end
