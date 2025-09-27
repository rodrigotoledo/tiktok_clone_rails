class CommentBlueprint < Blueprinter::Base
  identifier :id

  fields :body, :created_at

  association :user, blueprint: UserBlueprint
end
