require_relative "boot"

require "rails/all"  # Rails を先に読み込む
require "devise"

# development と test でのみ dotenv を読み込む
if Rails.env.development? || Rails.env.test?
  require "dotenv"
  Dotenv.load
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # lib 下の不要なサブディレクトリを無視
    config.autoload_lib(ignore: %w[assets tasks])

    # i18n 日本語化
    config.i18n.default_locale = :ja

    # ここにその他の設定を追加可能
  end
end
