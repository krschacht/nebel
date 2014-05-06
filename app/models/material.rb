class Material < ActiveRecord::Base

  validates_presence_of :name, if: "original_name.blank?"
  validates_presence_of :original_name, if: "name.blank?"

  has_many :requisitions
  has_many :exercises, through: :requisitions

  default_scope { order('archived') }

  before_validation :strip_whitespace_from_name_fields

  def display_name
    name || original_name
  end

  def archive
    update archived: true
  end

  def unarchive
    update archived: false
  end

private

  def strip_whitespace_from_name_fields
    self.name          = name.strip          if name.present?
    self.original_name = original_name.strip if original_name.present?
  end

end
