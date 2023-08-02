require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "Posts" do

    # before do
    #   @user = create(:michael) 
    # end

    let(:user) {FactoryBot.create(:michael)}

    context "new" do
      it "htmlが表示されること" do
        get login_path
        expect(response).to be_successful
      end
    end
  
    context "create" do
      it "login with valid email/invalid password" do
        get login_path
        expect(response).to render_template(:new)
        post login_path, params: { RSpec.configuration.session[:email] = @user.email,
          RSpec.configuration.session[:password] = "invalid" }
        click_button "Log in"
        expect(is_logged_in?).to eq(false)
        expect(response).to render_template(:new)
        expect(flash[:success]).to be_present
        get root_path
        expect(flash[:success]).to be_blank
      end

      it "login with valid information followed by logout" do
        get login_path
        post login_path, params: { RSpec.configuration.session[:email] = @user.email,
        RSpec.configuration.session[:password] = "password" }
        click_button "Log in"
        expect(is_logged_in?).to eq(true)
        expect(response).to redirect_to @user
        follow_redirect!
        expect(response).to render_template('users/show')
        expect(page).to_not have_link href: login_path
        expect(page).to have_link href: logout_path
        expect(page).to have_link href: user_path(user) 
        delete logout_path
        expect(is_logged_in?).to eq(false)
        expect(response).to redirect_to root_url
        # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
        delete logout_path
        follow_redirect!
        expect(page).to have_link href: login_path
        expect(page).to_not have_link href: logout_path
        expect(page).to_not have_link href: user_path(user) 
      end
    end
  end
end


  
    # test "login with remembering" do
    #   log_in_as(@user, remember_me: '1')
    #   assert_not_empty cookies[:remember_token]
    # end
  
    # test "login without remembering" do
    #   # cookieを保存してログイン
    #   log_in_as(@user, remember_me: '1')
    #   delete logout_path
    #   # cookieを削除してログイン
    #   log_in_as(@user, remember_me: '0')
    #   assert_empty cookies[:remember_token]
    # end

    # context "new" do
    #   it "htmlが表示されること" do
    #     get signup_path
    #     expect(response).to be_successful
    #   end
    # end

    # context "create & show" do
    #   it "登録に成功した場合、Userテーブルに追加されて、showテンプレートに遷移してflashが表示されること" do
    #     expect do
    #       post users_path, params: { user: { name:  "test1",
    #                                         email:  "test1@invalid.com",
    #                                      password:  "foobar",
    #                         password_confirmation:  "foobar" } }
    #     end.to change{ User.count }
    #     expect(response).to render_template(@user)
    #     expect(flash[:success]).to be_present
    #   end

    #   it "登録に失敗した場合、Userテーブルに追加されず、newテンプレートを表示すること" do
    #     expect do
    #       post users_path, params: { user: { name:  "",
    #                                         email:  "user@invalid",
    #                                      password:  "foo",
    #                         password_confirmation:  "bar" } }
    #     end.to_not change{ User.count }
    #     expect(response).to render_template(:new)
    #   end
    # end

