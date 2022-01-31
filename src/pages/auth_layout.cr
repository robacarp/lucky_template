abstract class AuthLayout < BaseLayout
  include Foundation::LayoutHelpers::Authenticated
  include Featurette::LayoutHelpers(Feature)
end
