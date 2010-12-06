class ConfirmationKey < ActiveRecord::Base
  belongs_to :user

  validates :key, :presence => true, :length => { :maximum => 40 }
end
