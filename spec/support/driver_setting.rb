RSpec.configure do |config|
    config.before(:each, type: :system) do
      # バージョン固定
      Webdrivers::Chromedriver.required_version = "114.0.5735.90"
            
      # Spec実行時、ブラウザが自動で立ち上がり挙動を確認できる
      # driven_by(:selenium_chrome)

      driven_by(:selenium, using: :headless_chrome, screen_size: [1400, 800]) do |options|
        options.add_argument('--lang=ja-jp')
      end


    end
  end