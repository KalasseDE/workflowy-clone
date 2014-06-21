require 'rails_helper'

RSpec.describe Item, :type => :model do

  context 'validations' do

    it 'validates when given a user_id, title and rank' do
      expect(create(:item)).to be_valid
    end

    it 'must have a user' do
      expect(build(:item, user_id: nil)).not_to be_valid
    end

    it 'must have a title' do
      expect(build(:item, title: nil)).not_to be_valid
    end

    it 'must have a rank' do
      expect(build(:item, rank: nil)).not_to be_valid
    end

    it 'cannot have the same rank as another item with the same parent' do
      parent = create(:item)
      first_child = parent.children.create(title: 'first', user_id: 1, rank: 1)
      second_child = parent.children.build(title: 'second', user_id: 1, rank: 1)
      expect(second_child).not_to be_valid
    end
  end
end