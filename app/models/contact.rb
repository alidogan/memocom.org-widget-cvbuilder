class Contact < ActiveRecord::Base

	has_and_belongs_to_many :groups

	attr_encrypted :first_name
	attr_encrypted :last_name
	attr_encrypted :email

	validates :encrypted_first_name, symmetric_encryption: true
	validates :encrypted_last_name, symmetric_encryption: true
	validates :encrypted_email, symmetric_encryption: true

end
