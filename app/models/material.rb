class Material < ActiveRecord::Base
  validates_presence_of :name, if: "original_name.blank?"
  validates_presence_of :original_name, if: "name.blank?"

  has_many :requisitions
  has_many :exercises, through: :requisitions

  default_scope { order('archived') }

  def archive
    update archived: true
  end

  def unarchive
    update archived: false
  end
end
