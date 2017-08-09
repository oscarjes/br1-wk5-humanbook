class User < ApplicationRecord
  validates :name, :email, presence: true
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_secure_password

  def image_url_or_default
    image_url.presence || "http://lorempixel.com/128/128/sports/Dummy-Text/"
  end

  def self.generate_users(n = 5, gender = "female")
    url = "https://randomuser.me/api?results=#{n}&gender=#{gender}"
    body = HTTP.get(url).parse
    body["results"].each do |person|
      hash = {}
      hash[:name] = person["name"]["first"] + " " + person["name"]["last"]
      hash[:email] = person["email"]
      hash[:password] = person["login"]["password"]
      hash[:image_url] = person["picture"]["large"]
      User.create! hash
    end
  end

  def is_friend?(another)
    friends.include?(another)
  end

  def add_friend(another)
    unless is_friend?(another)
      friends << another
    end
  end

  def remove_friend(another)
    friendships.find_by(friend_id: another.id).destroy
  end 

  def self.from_omniauth(auth)
    puts auth
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize
    user.password = [*('A'..'Z')].sample(8).join
    user.name = auth[:info][:name]
    user.image_url = auth[:info][:image]
    user.save && user
  end
end
