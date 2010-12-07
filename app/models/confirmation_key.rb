class ConfirmationKey < ActiveRecord::Base
  belongs_to :user

  validates :key, :presence => true, :length => { :is => 40 }
end
