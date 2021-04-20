require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'is valid' do
    task = FactoryBot.build(:task)
    expect(task).to be_valid
    expect(task.errors).to be_invalid  
  end

  it 'is invalid without title' do
    task = FactoryBot.build(:task, title: nil)
    expect(task).to be_invalid
    expect(task.errors[:title]).to eq ["can't be blank"]
  end

  it 'is invalid with a duplicate title' do
    FactoryBot.create(:task, title:"Test")
    task = FactoryBot.build(:task, title: "Test")
    expect(task).to be_invalid
  end

  it 'is valid another_title' do
    FactoryBot.create(:task, title: "Test")
    task = FactoryBot.build(:task, title:"Test_another")
    expect(task).to be_valid
  end

  it 'is invalid without status' do
    task = FactoryBot.build(:task, status: nil)
    task.valid?
    expect(task.errors[:status]).to include("can't be blank")  
  end
end
