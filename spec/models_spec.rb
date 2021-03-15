require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end

RSpec.describe Friendship, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
end

RSpec.describe Like, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:posts) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
  end
end

RSpec.describe 'Validations', type: :model do
  let!(:user) { User.new(id: 1, name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  let!(:post) { Post.new(content: 'Hello World!', user_id: 1) }
  let!(:comment) { Comment.new(content: 'Hello!', user_id: 1, post_id: 1) }
  let!(:like) { Like.new(user_id: 1, post_id: 1) }

  describe 'User Validations' do
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

  describe 'Post Validations' do
    it 'Is valid with content.' do
      expect(post).to be_valid
    end

    it 'Content must be 1000 characters or less.' do
      post.content = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      expect(post).to_not be_valid
    end

    it 'Content must be present.' do
      post.content = nil
      expect(post).to_not be_valid
    end
  end

  describe 'Comment Validations' do
    it 'Is valid with content.' do
      user.save
      post.save
      expect(comment).to be_valid
    end

    it 'Content must be 1000 characters or less.' do
      post.content = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      expect(post).to_not be_valid
    end

    it 'Content must be present.' do
      post.content = nil
      expect(post).to_not be_valid
    end
  end
end
