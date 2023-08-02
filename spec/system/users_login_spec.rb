require 'rails_helper'

RSpec.describe "UsersLogin", type: :system do
  describe "GET" do

    context '正常にログイン＆ログアウト' do
      it "doesn't have a link to login, has a link to logout and a link to user/id" do
        user = FactoryBot.create(:user)
        visit login_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"

        it "doesn't have a link to login, has a link to logout and a link to user/id" do
          user = FactoryBot.create(:user)
          visit login_path
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Log in"
  
          expect(page).to_not have_link "Log in", href: login_path
          expect(page).to have_link "Log out", href: logout_path
          expect(page).to have_link "Profile", href: user_path(user)
        end
      end
      it "ログイン成功" do
        user=FactoryBot.attributes_for(:user)
        post users_path, params: { user: user }
        expect(is_logged_in?).to be_truthy
      end
      it 'ログアウト' do
        user = FactoryBot.create(:user)
        # 一旦ログイン
        get login_path
        post login_path params: { session: { email: user.email,
                                          password: user.password } }
        expect(is_logged_in?).to be_truthy
        # ログアウト
        delete logout_path
        expect(is_logged_in?).to_not be_truthy
        #be_falsey → nilか空白であればfalseです
        expect(session[:user_id]).to be_falsey # => nil
      end
    end

    context "ログインに失敗した時" do
      it "フラッシュメッセージの残留をキャッチすること" do
        get login_path
        expect(response).to have_http_status(:success)

        #「email:""」と「password:""」の値を持ってlogin_pathにアクセス
        # → バリデーションに引っかかりログインできない
        post login_path, params: { session: { email: "", password: "" }}
        expect(response).to have_http_status(:success)
        #flash[:danger]が表示されているかチェック
        expect(flash[:danger]).to be_truthy

        #root_path（別ページ）に移動してflash[:danger]が表示されていないかチェック
        get root_path
        expect(flash[:danger]).to be_falsey
      end
    end
  end
end
