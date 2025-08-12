require 'faker'


# Ensure a specific user exists
User.find_or_create_by!(email_address: 'faker@test.com') do |user|
  user.password = 'faker@test.com'
  user.password_confirmation = 'faker@test.com'
end

10.times.each do
  User.find_or_create_by!(email_address: Faker::Internet.unique.email) do |user|
    user.password = 'password123'
    user.password_confirmation = 'password123'
  end
end

MEDIA_FILES = [
  { path: 'example.mp3', type: 'audio/mpeg' },
  { path: 'example.mp4', type: 'video/mp4' },
  { path: 'example.png', type: 'image/png' }
]
users = User.all.to_a

users.each do |user|
  10.times do |i|
    post = user.posts.build(
      title: "Post #{i + 1} - #{Faker::Lorem.sentence}",
      body: Faker::Lorem.paragraph(sentence_count: 3)
    )

    media = MEDIA_FILES.sample

    post.media_file.attach(
      io: File.open(Rails.root.join('lib', media[:path])),
      filename: "media_#{i}.#{media[:path].split('.').last}",
      content_type: media[:type]
    )

    post.save!

    rand(1..5).times do
      commenter = users.sample
      comment = post.comments.build(
        user: commenter,
        body: Faker::Lorem.sentence(word_count: 8)
      )
      comment.save!
    end
  end
end
