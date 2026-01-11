class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # because of UUIDV4 generation time not being strictly increasing
  default_scope { order(:created_at) }
end
