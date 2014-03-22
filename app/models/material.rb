class Material < ActiveRecord::Base
  validates_presence_of :name, if: "original_name.blank?"
  validates_presence_of :original_name, if: "name.blank?"

  has_many :requisitions
  has_many :exercises, through: :requisitions

  def archive
    update_attribute :archived, true
  end

  def unarchive
    update_attribute :archived, false
  end
end
