class SignInUser < Avram::Operation
  param_key :user

  attribute email : String
  attribute password : String

  # Run validations and yields the operation and the user if valid
  def run
    if email_ = email.value
      user = User.from_email email_
    end

    validate_credentials user

    if valid?
      user
    else
      nil
    end
  end

  # `validate_credentials` determines if a user can sign in.
  #
  # If desired, you can add additional checks in this method, e.g.
  #
  #    if user.locked?
  #      email.add_error "is locked out"
  #    end
  private def validate_credentials(user)
    unless user
      email.add_error "is not in our system"
      return
    end

    unless user.correct_password?(password.value.to_s)
      password.add_error "is wrong"
    end
  end
end
