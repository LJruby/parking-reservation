class ApplicationRecord < ActiveRecord::Base
  self.table_name='reservations'
  self.abstract_class = true
end

