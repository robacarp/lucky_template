class Admin::Users::Show < AdminAction
  get "/users/:id" do
    user = UserQuery.new
      .preload_enabled_features(
        EnabledFeatureQuery.new.preload_feature
      )
      .find(id)

    html ShowPage, user: user
  end
end
