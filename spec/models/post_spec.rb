# frozen_string_literal: true

require 'rails_helper'

require 'faker'

RSpec.configure do |config|
  config.before(:suite) do
    fixtures_dir = Rails.root.join('spec/fixtures/files')
    FileUtils.mkdir_p(fixtures_dir)

    # Create dummy media files (content doesn't need to be valid for these tests)
    File.write(fixtures_dir.join('test_image.jpg'), 'dummy image content')
    File.write(fixtures_dir.join('test_video.mp4'), 'dummy video content')
    File.write(fixtures_dir.join('test_audio.mp3'), 'dummy audio content')

    # Create text file with faker content
    File.write(fixtures_dir.join('test_file.txt'), Faker::Lorem.paragraph)
  end
end

RSpec.describe Post, type: :model do
  let(:user) { create(:user) } # Assuming a User factory exists
  let(:post) { build(:post, user: user) } # Assuming a Post factory exists

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one_attached(:media_file) }
  end

  describe 'validations' do
    context 'with acceptable media file' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpeg')
      end

      it 'is valid' do
        expect(post).to be_valid
      end
    end

    context 'with unacceptable content type' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_file.txt')), filename: 'test_file.txt', content_type: 'text/plain')
      end

      it 'is invalid' do
        expect(post).not_to be_valid
        expect(post.errors[:media_file]).to include('Must be an audio or video file')
      end
    end

    context 'with file size exceeding limit' do
      before do
        large_file = Tempfile.new('large_file')
        large_file.write('x' * (51.megabytes))
        post.media_file.attach(io: large_file, filename: 'large_file.mp4', content_type: 'video/mp4')
      end

      it 'is invalid' do
        expect(post).not_to be_valid
        expect(post.errors[:media_file]).to include('can not have more than 50 mb')
      end
    end
  end

  describe '#photo_post?' do
    context 'when media_file is an image' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpeg')
      end

      it 'returns true' do
        expect(post.photo_post?).to be true
      end
    end

    context 'when media_file is not an image' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_video.mp4')), filename: 'test_video.mp4', content_type: 'video/mp4')
      end

      it 'returns false' do
        expect(post.photo_post?).to be false
      end
    end

    context 'when no media_file is attached' do
      it 'returns false' do
        expect(post.photo_post?).to be false
      end
    end
  end

  describe '#video_post?' do
    context 'when media_file is a video' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_video.mp4')), filename: 'test_video.mp4', content_type: 'video/mp4')
      end

      it 'returns true' do
        expect(post.video_post?).to be true
      end
    end

    context 'when media_file is not a video' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_audio.mp3')), filename: 'test_audio.mp3', content_type: 'audio/mpeg')
      end

      it 'returns false' do
        expect(post.video_post?).to be false
      end
    end

    context 'when no media_file is attached' do
      it 'returns false' do
        expect(post.video_post?).to be false
      end
    end
  end

  describe '#audio_post?' do
    context 'when media_file is audio' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_audio.mp3')), filename: 'test_audio.mp3', content_type: 'audio/mpeg')
      end

      it 'returns true' do
        expect(post.audio_post?).to be true
      end
    end

    context 'when media_file is not audio' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpeg')
      end

      it 'returns false' do
        expect(post.audio_post?).to be false
      end
    end

    context 'when no media_file is attached' do
      it 'returns false' do
        expect(post.audio_post?).to be false
      end
    end
  end

  describe '#media_type' do
    context 'when media_file is audio' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_audio.mp3')), filename: 'test_audio.mp3', content_type: 'audio/mpeg')
      end

      it 'returns "audio"' do
        expect(post.media_type).to eq('audio')
      end
    end

    context 'when media_file is video' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_video.mp4')), filename: 'test_video.mp4', content_type: 'video/mp4')
      end

      it 'returns "video"' do
        expect(post.media_type).to eq('video')
      end
    end

    context 'when media_file is image' do
      before do
        post.media_file.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpeg')
      end

      it 'returns "image"' do
        expect(post.media_type).to eq('image')
      end
    end

    context 'when no media_file is attached' do
      it 'returns nil' do
        expect(post.media_type).to be_nil
      end
    end
  end
end
