require 'rails_helper'

RSpec.describe User, type: :model do

  describe "User#new" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com")
    end

    context "インスタンス生成時" do
      it "Userモデルをnewしたとき、nilではないこと" do
        expect(User.new).not_to eq(nil)
      end
    end

    context "nameチェック" do
      it "nameが空白の場合、バリデーションFalseになること" do
        @user.name = ""
        expect(@user.valid?).to eq(false)
      end

      it "nameの文字数が50文字以上の場合、バリデーションFalseになること" do
        @user.name = "a" * 51
        expect(@user.valid?).to eq(false)
      end
    end

    context "emailチェック" do
      it "emailが空白の場合、バリデーションFalseになること" do
        @user.email = ""
        expect(@user.valid?).to eq(false)
      end

      it "emailの文字数が255文字以上の場合、バリデーションFalseになること" do
        @user.email = "a" * 255 + "@example.com"
        expect(@user.valid?).to eq(false)
      end

      it "emailがメールアドレスの形式でない場合、バリデーションFalseになること" do
        valid_addresses = %w[userexample.com USER@foo/.COM A_US-ER@@foo.bar.org
                             first.last@foo._jp alice+)bob@baz.cn]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user.valid?).to eq(false), "#{valid_address.inspect} should be not valid"
        end
      end

      it "emailが重複する場合、バリデーションFalseになること" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        expect(duplicate_user.valid?).to eq(false)
      end
    end

    context "remember_digestチェック" do
      it "remember_digestが nil の場合、認証でfalseになること" do
        expect(@user.authenticated?("")).to eq(false)
      end
    end

  end

end
