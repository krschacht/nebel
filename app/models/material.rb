class Material < ActiveRecord::Base

  validates_presence_of :name, if: "original_name.blank?"
  validates_presence_of :original_name, if: "name.blank?"

  has_many :requisitions
  has_many :exercises, through: :requisitions

  default_scope { order('archived') }

  before_validation :strip_whitespace_from_name

  def display_name
    name || original_name
  end

  def archive
    update archived: true
  end

  def unarchive
    update archived: false
  end

  def inconsistent_quantities?
    quantities = requisitions.collect { |r| r.quantity }
    includes_nil = quantities.include?( nil )
    quantities.delete(nil)

    includes_nil && quantities.length > 0
  end

private

  def strip_whitespace_from_name
    self.name = name.strip if name.present?
  end

end
