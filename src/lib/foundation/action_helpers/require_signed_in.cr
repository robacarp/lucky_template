module Foundation::ActionHelpers::RequireSignedIn
  macro included
    before require_sign_in
  end

  # Inspired by Authentic
  def remember_requested_path
    if request.method.upcase == "GET"
      session.set(:return_to, request.resource)
    end
  end

  private def require_sign_in
    if current_user?
      continue
    else
      remember_requested_path
      flash.info = "Please sign in first"
      redirect to: SignIns::New
    end
  end

  # Tells the compiler that the current_user is not nil since we have checked
  # that the user is signed in
  private def current_user : User
    current_user?.not_nil!
  end
end
