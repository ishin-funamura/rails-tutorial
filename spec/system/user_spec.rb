require "rails_helper"

RSpec.describe "User", type: :system do
  it "GET /signup" do
    visit "/signup" # /userへHTTPメソッドGETでアクセス
    expect(page).to have_text("Sign up") # 表示されたページに Sign up という文字があることを確認
  end
end