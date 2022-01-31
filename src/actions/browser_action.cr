abstract class BrowserAction < Lucky::Action
  include Lucky::ProtectFromForgery

  # This module disables Google FLoC by setting the
  # [Permissions-Policy](https://github.com/WICG/floc) HTTP header to `interest-cohort=()`.
  #
  # This header is a part of Google's Federated Learning of Cohorts (FLoC) which is used
  # to track browsing history instead of using 3rd-party cookies.
  #
  # Remove this include if you want to use the FLoC tracking.
  include Lucky::SecureHeaders::DisableFLoC

  include Foundation::ActionHelpers::Authentication(User, UserQuery)
  include Pundit::ActionHelpers(User)
  include Featurette::ActionHelpers

  accepted_formats [:html, :json], default: :html

  private def query_for_user(user_id) : User?
    UserQuery.new
      .preload_enabled_features(EnabledFeatureQuery.new.preload_feature)
      .preload_features
      .id(user_id).first?
  end

  private def is_admin?(user : User) : Bool
    user_can? user, :admin
  end
end
