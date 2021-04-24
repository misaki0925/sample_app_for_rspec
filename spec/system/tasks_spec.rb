require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  describe 'ログイン前' do
    context 'ログイン処理が成功する' do
      it 'is success login'
      visit login_path
      fill_in 'email', with: user.email
      fill_in 'password',	with: user.password
      fill_in 'password_confirmation',	with: user.password
      click_button 'ログイン'
      expect(current_path).to eq root_path
      expect(page).to have_content 'Login successful'  
    end
    context 'フォームが未入力' do
      it 'fail to login'
      visit login_path
      fill_in 'email', with: nil
      fill_in 'password',	with: nil
      fill_in 'password_confirmation',	with: nil
      expect(current_path).to login_path
      expect(page).to have_content 'Login failed'
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'is success logout'
      click_button 'logout'
      expect(page).to have_content 'Logged out'  
      expect(current_path).to eq root_path
    end
    context 'タスクの新規作成' do
      it 'is success to create new task'
      visit new_task_path
      fill_in 'Title',	with: 'test_title'
      fill_in 'Content',	with: 'test_content'
      select 'doing', form: 'Status'
      fill_in 'Deadline',	with: DateTime.new(2021,4,23,12,15)
      click_button 'Create task'
      expect(page).to have_content 'Task was successfully created.'
      expect(page).to have_content 'test_title'
      expect(page).to have_content 'test_content'
      expect(current_path) to eq task_path(task)
      expect().to  
    end
    context 'タスクの編集' do
      it 'is succe to create new task'
      visit edit_task_path(task)
      fill_in 'Title',	with: 'update_title'
      fill_in 'Content',	with: 'update_content'
      select 'doing', form: 'Status'
      fill_in 'Deadline',	with: DateTime.new(2021,4,23,12,20)
      click_button 'Update task'
      expect(page).to have_content 'Task was successfully updated.'
      expect(page).to have_content 'update_title'
      expect(page).to have_content 'update_content'
      expect(current_path) to eq task_path(task)
    end

    context 'タスクの削除' do
      it 'is success to delete task'
      vidit tasks_path
      click_link 'Destroy'
      expect(page).to have_content 'Task was successfully destroyed.'
      expect(current_path).to eq tasks_path
    end
    
    
    
  end
end
