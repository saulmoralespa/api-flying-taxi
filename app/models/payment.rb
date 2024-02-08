class Payment < ActiveRecord::Base
    has_one :rider
end