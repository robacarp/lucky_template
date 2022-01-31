class My::Password::ShowPage < AuthLayout
  needs user : User
  needs save : User::ChangePassword

  def content
    small_frame do
      header_and_links "Change Password" do
        link "My Account", to: My::Account::Show
      end

      form_for My::Password::Update do
        mount Shared::Field, attribute: save.old_password, &.password_input(placeholder: "*************")
        mount Shared::Field, attribute: save.password, &.password_input(placeholder: "*************")
        mount Shared::Field, attribute: save.password_confirmation, &.password_input(placeholder: "*************")

        submit "Change Password"
      end
    end
  end
end
