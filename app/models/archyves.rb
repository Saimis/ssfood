class Archyves < ActiveRecord::Base
  serialize :callers, Array
  serialize :payers, Array
  serialize :gcs, Array
end
