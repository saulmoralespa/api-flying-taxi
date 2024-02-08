class Ride < ActiveRecord::Base
    belongs_to :rider, foreign_key: 'riders_id'
    belongs_to :driver, foreign_key: 'drivers_id'
end