# frozen_string_literal: true

class Post < ApplicationRecord
  validates :user_name, { presence: true }, { length: { in: 1..20 } }
  validates :title, { presence: true }, { length: { in: 1..20 } }
  validates :message, { presence: true }, { length: { in: 1..200 } }
end
