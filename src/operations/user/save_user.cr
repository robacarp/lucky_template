class SaveUser < User::SaveOperation
  permit_columns email

  before_save do
    if email.changed?
      validate_uniqueness_of email
      email_valid.value = User::Validity::Unchecked
    end
  end
end
