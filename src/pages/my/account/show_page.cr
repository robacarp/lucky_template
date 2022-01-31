class My::Account::ShowPage < AuthLayout
  needs user : User
  needs save : SaveUser

  def content
    small_frame do
      header_and_links "Your Account" do
        link "Sign out", to: SignIns::Delete
        middot_sep
        link "Change your password", to: My::Password::Change
      end

      form_for My::Account::Update do
        mount Shared::Field, attribute: save.email, &.text_input
        submit "Save", class: "btn btn-primary"
      end
    end
  end
end
