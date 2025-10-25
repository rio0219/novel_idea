module ApplicationHelper
  def default_meta_tags
    {
      site: "TSUMUGIBA",
      title: "アイデアを、つむぐ場所。",
      reverse: true,
      charset: "utf-8",
      description: "小説やアイデアをAIと一緒につむぐ、創作サポートアプリ。",
      keywords: "小説, アイデア, 創作, AI, ポートフォリオ",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: "TSUMUGIBA",
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("ogp.png"),
        locale: "ja_JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_account"
      }
    }
  end
end
