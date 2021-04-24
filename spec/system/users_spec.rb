require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'is success create new user'
        visit sign_up_path
        fill_in 'Email',	with: 'test@example.com'
        fill_in 'Password',	with: 'password'
        fill_in 'Password confirmation',	with: 'password' 
        click_button 'Signup'
        expect(current_path).to eq login_path  
        expect(page).to have_content 'User was successfully created.'
      end
      context 'メールアドレスが未入力' do
        it 'is fail to create new user'
        visit sign_up_path
        fill_in 'Email',	with: 'nil'
        fill_in 'Password',	with: 'password'
        fill_in 'Password confirmation',	with: 'password'
        click_button 'Signup'
        expect(current_path).to eq new_user_path
        expect(page).to have_content "Email can't be blank"  
      end
      context '登録済みのメールアドレスを使用' do
        it 'is fail to create new user'
        visit sign_up_path
        fill_in 'Email',	with: 'user.email'
        fill_in 'Password',	with: 'password'
        fill_in 'Password confirmation',	with: 'password'
        click_button 'Signup'
        expect(current_path).to eq sign_up_path
        expect(page).to have_content "Email has already been taken"  
      end
    end
    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'is fail to access mypage'
        visit user_path(user)
        expect(current_path).to eq login_path
        expecte(user.errors[:user]).to eq ["ログインしてください"]
      end
    end

    describe 'ログインしていないユーザー' do
      context '編集ページにアクセス' do
        it 'is fail to access another_user page'
        visit edit_user_path(another_user)
        expect(current_path).to eq login_path  
        expect(page).to have_content 'Please login'  
      end
      context 'タスクを新規作成する' do
        it 'is fail to create new task'
          visit new_task_path
          expect(current_path).to eq login_path
      end
    end
  end

  describe '他のユーザー' do
    context 'ユーザー編集へ遷移' do
      visit edit_user_path(another_user)
      expect(current_path).to eq login_path
      expect(page).to have_content 'Please login'
    end
    context 'タスク編集ページへ遷移' do
      visit edit_task_path(another_user)
      expect(current_path).to eq login_path
      expect(page).to have_content 'Please login'
    end
    
    
    
  end
  

  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'is success to edit user'
        visit edit_user_path(user)
        fill_in 'email',	with: 'test@example.com'
        fill_in 'password',	with: 'password'
        fill_in 'password_confirmation',	with: 'password'
        click_button 'Update'
        expect(current_path).to eq user_path(user)
        expect(page).to have_content 'User was successfully updated.'  
      end
      context 'メールアドレスが未入力' do
        it 'is fail to update user'
        visit edit_user_path(user)
        fill_in 'email',	with: nil
        fill_in 'password',	with: 'password'
        fill_in 'password_confirmation',	with: 'password'
        click_button 'Update'
        expect(current_path).to eq edit_user_path(user)
        expect(page).to have_content "Email can't be blank"  
      end
      context '使用済みのメールアドレスを使用' do
        it 'is fail to update user'
        fill_in 'email',	with: user.email
        fill_in 'password',	with: 'password'
        fill_in 'password_confirmation',	with: 'password'
        click_button 'Update'
        expect(current_path).to eq edit_user_path(user)
        expect(page).to have_content 'Email has already been taken'  
      end

    describe 'マイページ' do
      before { login(user) }
      context 'タスクを作成' do
        it 'is show a new task'
        visit tasks_path
        fill_in 'title',	with: 'title'
        fill_in 'content',	with: 'content'
        fill_in 'status',	with: 'todo' 
        fill_in 'deadline',	with: '1.week.from_now'
        click_button 'create'
        expect(current_path).to eq  task_path(task)
        expect(page).to have_content 'Task was successfully created.' 
      end
    end
  end
end
