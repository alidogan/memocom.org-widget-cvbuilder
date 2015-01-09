class Group < ActiveRecord::Base

	has_and_belongs_to_many :contacts

	attr_encrypted :name

	validates :encrypted_name, symmetric_encryption: true


end
