class Rating < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :article
end
