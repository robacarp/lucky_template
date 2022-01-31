class User::RequestPasswordReset < Avram::Operation
  attribute email : String

  # Run validations and yield the operation and the user if valid
  def run
    if email_ = email.value
      user = User.from_email email_
    end

    validate user

    if valid?
      user
    else
      nil
    end
  end

  def validate(user : User?)
    validate_required email
    if user.nil?
      email.add_error "is not in our system"
    end
  end
end
