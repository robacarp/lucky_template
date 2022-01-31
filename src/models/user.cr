class User < BaseModel
  include Carbon::Emailable
  include Foundation::ModelHelpers::Authentication

  enum Validity
    Unchecked = 1024
    Valid = 0
    Invalid = 1
  end

  table :users do
    column email : String
    column encrypted_password : String

    column email_valid : User::Validity = User::Validity::Unchecked

    has_many enabled_features : EnabledFeature
    has_many features : Feature, through: [:enabled_features, :feature]
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end

  def activated?
    is? :active
  end

  def self.from_email(email : String) : User?
    UserQuery.new.email(email).first?
  end
end
