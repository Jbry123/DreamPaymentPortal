class AddCampaignVideoToCompaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :compaigns, :campaignVideo, :string
  end
end
