class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_one_attached :media_file
  validate :acceptable_media_file

  def photo_post?
    media_file.attached? && media_file.content_type.start_with?('image/')
  end

  def video_post?
    media_file.attached? && media_file.content_type.start_with?('video/')
  end

  def audio_post?
    media_file.attached? && media_file.content_type.start_with?('audio/')
  end

  def media_type
    return unless media_file.attached?

    if media_file.content_type.start_with?('audio/')
      'audio'
    elsif media_file.content_type.start_with?('video/')
      'video'
    elsif media_file.content_type.start_with?('image/')
      'image'
    end
  end

  private

  def acceptable_media_file
    return unless media_file.attached?

    unless media_file.content_type.in?(%w[image/jpeg image/png video/mp4 video/quicktime audio/mpeg audio/wav])
      errors.add(:media_file, "Must be an audio or video file")
    end

    max_size = 50.megabytes
    if media_file.byte_size > max_size
      errors.add(:media_file, "can not have more than #{max_size / 1.megabyte} mb")
    end
  end
end
