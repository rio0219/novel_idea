class ApplicationController < ActionController::Base
  include MetaTags::ControllerHelper

  def default_meta_tags
    {
      site: "TSUMUGIBA",
      title: "小説アイデアを紡ぐ場所",
      reverse: true,
      charset: "utf-8",
      description: "あなたの創作アイデアを共有・成長させるアプリTSUMUGIBA。",
      keywords: "小説, アイデア, 共有, 執筆, 創作",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: "TSUMUGIBA",
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: ActionController::Base.helpers.asset_url("ogp.png") # OGP画像
      },
      twitter: {
        card: "summary_large_image",
        site: "@tsumugiba_app"
      }
    }
  end
end
