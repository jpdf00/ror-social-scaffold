require 'rails_helper'

RSpec.describe 'Siggin Up', type: :feature do
  scenario 'Sign up with valid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Foo Bar'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    sleep(3)
    visit root_path
    expect(page).to have_content('Foo Bar')
  end

  scenario 'Sign up with invalid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    sleep(3)
    visit root_path
    expect(page).to_not have_content('Foo Bar')
  end
end

RSpec.describe 'Sign In', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Log in with valid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Foo Bar')
  end

  scenario 'Log in with invalid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: 'Banana'
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to_not have_content('Foo Bar')
  end
end

RSpec.describe 'Loggin Out', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Log Out' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    click_on 'Sign Out'
    sleep(3)
    visit root_path
    expect(page).to have_content('Sign In')
  end
end

RSpec.describe 'Create Post', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Create new post with valid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    expect(page).to have_content('HELLOOO')
  end

  scenario 'Create post with blank inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: ''
    click_on 'Save'
    expect(page).to_not have_content('HELLOOO')
  end
end

RSpec.describe 'Likes', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Like post' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    click_on 'Like!'
    expect(page).to have_content('Dislike!')
  end

  scenario 'Dislike post' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    click_on 'Like!'
    click_on 'Dislike!'
    expect(page).to have_content('Like!')
  end
end

RSpec.describe 'Create new comment', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Create comment' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    fill_in :comment_content, with: 'very good!'
    click_on 'Comment'
    expect(page).to have_content('very good!')
  end

  scenario 'Comment in blank' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    fill_in :comment_content, with: ''
    click_on 'Comment'
    expect(page).to have_content("Content can't be blank")
  end
end
