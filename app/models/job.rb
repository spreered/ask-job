class Job < ApplicationRecord
  scope :sysnam_like, ->(sysnam_text){
    where("sysnam LIKE ?","%#{sysnam_text}%")
  }
end
