class AddProviderToIdentity < ActiveRecord::Migration[5.0]
  def change
    add_column :identities, :provider, :string
  end
end
