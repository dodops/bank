class Users::CreateService
  def self.call(params = {})
    user = User.new params
    user.api_token = SecureRandom.hex
    user.save
    user
  end
end
