ActiveAdmin.register Compaign do  
    permit_params :recipient, :artistName, :bigGoal, :bigProblem, :paragraphText, :moneyGoal, :campaignPhoto, :campaignVideo
end
