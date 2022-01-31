class CreateUsers::V20181214214853 < Avram::Migrator::Migration::V1
  def migrate
    create :users do
      primary_key id : Int64
      add email : String, unique: true
      add encrypted_password : String

      add invite_id : Int32?
      add_timestamps
      add email_valid : Int32 = 1024, default: 1024
    end
  end

  def rollback
    drop :users
  end
end
