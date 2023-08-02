require 'rails_helper'

RSpec.describe "UsersSignups", type: :system do
  describe "POST" do
    let(:user) { FactoryBot.attributes_for(:user) }

    context 'パラメータOK' do
      it "リクエストが成功すること" do
        get signup_path
        # expect(response).to have_http_status(302)
        expect(response).to be_successful
    end
      it 'ユーザーが登録されること' do
        expect{
          post users_path, params: { user: user }
        }.to change(User, :count).by 1
      end
      it 'リダイレクトすること' do
        post users_path, params: { user: user }
        # showテンプレート表示
        expect(response).to redirect_to User.last
        # Flash表示
        expect(flash[:success]).to be_present
      end
    end

    context 'パラメータNG' do
      it 'ユーザーが登録されないこと' do
        expect{
          post users_path, params: { user: { name: "",
                                      email: "address@invalid",
                                      password: "short",
                                      password_confirmation: "rack"}}
        }.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        expect{
          post users_path, params: { user: { name: "",
                                      email: "address@invalid",
                                      password: "short",
                                      password_confirmation: "rack"}}
        }.to_not change(User, :count)
        # エラーが表示されること
        expect(response.body).to include "error"
      end
    end
  end
end
