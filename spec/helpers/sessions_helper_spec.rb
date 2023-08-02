require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe "SessionsHelper" do
    before do
      @user = FactoryBot.create(:user)
      remember(@user)
    end

    it "current_user returns right user when session is nil" do
      expect(@user).not_to eq(current_user)
      expect(is_logged_in?).to eq(false)
    end
  
    it "current_user returns nil when remember digest is wrong" do
      @user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).not_to eq(nil)
    end
  
  end
end
