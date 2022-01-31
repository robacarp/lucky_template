class Foundation::SudoToolbar(UserModel) < Lucky::BaseComponent
  needs current_user : UserModel?
  needs admin_user : UserModel?

  def render
    return unless current_user_ = current_user
    return unless admin_user_ = admin_user
    return unless current_user_ != admin_user_

    div id: "sudo-toolbar" do
      para "Impersonating #{current_user_.email}"

      link to: Admin::Users::EndImpersonation,
        data_confirm: "Are you sure you want to un-impersonate?" do
        text "Exit"
      end
    end
  end
end
