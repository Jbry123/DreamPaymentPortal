class AddCampaignPhotoToCompaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :compaigns, :campaignPhoto, :string
  end
end
