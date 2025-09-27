class PostBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :body, :created_at

  field :media_type

  field :media_file do |post, _options|
    if post.media_file.attached?
      Rails.application.routes.url_helpers.rails_blob_url(post.media_file, host: 'localhost:3000')
    end
  end

  association :user, blueprint: UserBlueprint
end
