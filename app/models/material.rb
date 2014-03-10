class Material < ActiveRecord::Base
  validates_presence_of :name, if: "original_name.blank?"
  validates_presence_of :original_name, if: "name.blank?"
end
