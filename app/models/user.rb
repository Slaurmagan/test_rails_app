class User < ApplicationRecord
    validates :username,presence: true,uniqueness: {case_sensetive: false} , length: {minimum:3, maximum: 20}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence: true,length: {minimum:7, maximum:30},uniqueness:{case_sensetive: false},format: {with: VALID_EMAIL_REGEX}


end