class PasswordResetRequestEmail < BaseEmail
  def initialize(@user : User, @token : String)
  end

  to @user
  subject "Reset your password"
  templates html, text
end
