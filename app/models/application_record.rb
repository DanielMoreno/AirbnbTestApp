class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ## Helepr function to convert an array to a enum hash
  def self.array_to_enum_hash(array)
    Hash[array.map { |el| [el, el] }]
  end
end
