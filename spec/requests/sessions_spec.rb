require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "Posts" do

    context "new" do
      it "htmlが表示されること" do
        get signup_path
        expect(response).to be_successful
      end
    end

    context "create & show" do
      it "登録に成功した場合、Userテーブルに追加されて、showテンプレートに遷移してflashが表示されること" do
        expect do
          post users_path, params: { user: { name:  "test1",
                                            email:  "test1@invalid.com",
                                         password:  "foobar",
                            password_confirmation:  "foobar" } }
        end.to change{ User.count }
        expect(response).to render_template(@user)
        expect(flash[:success]).to be_present
      end

      it "登録に失敗した場合、Userテーブルに追加されず、newテンプレートを表示すること" do
        expect do
          post users_path, params: { user: { name:  "",
                                            email:  "user@invalid",
                                         password:  "foo",
                            password_confirmation:  "bar" } }
        end.to_not change{ User.count }
        expect(response).to render_template(:new)
      end
    end

  end

end
