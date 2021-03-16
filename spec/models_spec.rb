require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }

  describe 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:posts) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
  end

  describe 'Validations' do
    it 'Is valid with name.' do
      expect(user).to be_valid
    end

    it 'Name must be 20 characters or less.' do
      user.name = 'Joao Paulo Dias Franca'
      expect(user).to_not be_valid
    end

    it 'Name must be present.' do
      user.name = nil
      expect(user).to_not be_valid
    end
  end
end

RSpec.describe Post, type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  let!(:post) { Post.new(content: 'Hello World!', user_id: 1) }

  describe 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'Validations' do
    it 'Is valid with content.' do
      user.save
      expect(post).to be_valid
    end

    it 'Content must be 1000 characters or less.' do
      str = ' '
      1002.times { str << 'a' }
      post.content = str
      expect(post).to_not be_valid
    end

    it 'Content must be present.' do
      post.content = nil
      expect(post).to_not be_valid
    end
  end
end

RSpec.describe Comment, type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  let!(:post) { Post.new(id: 1, content: 'Hello World!', user_id: 1) }
  let!(:comment) { Comment.new(content: 'Hello!', user_id: 1, post_id: 1) }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'Comment Validations' do
    it 'Is valid with content.' do
      user.save
      post.save
      expect(comment).to be_valid
    end

    it 'Content must be 200 characters or less.' do
      str = ' '
      202.times { str << 'a' }
      post.content = str
      expect(post).to_not be_valid
    end

    it 'Content must be present.' do
      post.content = nil
      expect(post).to_not be_valid
    end
  end
end

RSpec.describe Like, type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  let!(:post) { Post.new(id: 1, content: 'Hello World!', user_id: 1) }
  let!(:like1) { Like.new(user_id: 1, post_id: 1) }
  let!(:like2) { Like.new(user_id: 1, post_id: 1) }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'Validations' do
    it 'Is valid.' do
      user.save
      post.save
      expect(like1).to be_valid
    end

    it 'Must not be duplicated.' do
      like1.save
      expect(like2).to_not be_valid
    end
  end
end

RSpec.describe Friendship, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
end
