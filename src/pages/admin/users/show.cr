class Admin::Users::ShowPage < AuthLayout
  needs user : User

  def content
    small_frame do
      header_and_links user.email do
        link "Assume User", to: Admin::Users::Impersonate.with(user), data_confirm: "Are you sure?"
      end

      user_enabled_features if user.enabled_features.any?
    end
  end


  def user_enabled_features
    h3 "Enabled Features"
    hr

    ul do
      user.enabled_features.each do |grant|
        li do
          link grant.feature.name, to: Features::Show.with(grant.feature)
        end
      end
    end
  end

end
