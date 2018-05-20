require 'rails_helper'
require Rails.root.join('lib', 'factory_helpers', 'add_points_to_user.rb')

RSpec.describe Redemption, type: :model do
  it { should belong_to :user }
  it { should belong_to :prize }

  it 'should be invalid if the user does not have enough points' do
    redemption = build :redemption, :invalid, user: create(:user)

    expect(redemption.errors[:base]).to include \
      t('activerecord.errors.models.redemption.not_enough_points')
  end

  it 'should be valid when it is re-instantiated (even if the user is out of '\
     'points)' do
    user = create :user
    AddPointsToUser.new(user, 1)
    prize = create :prize, cost: 1
    create :redemption, prize: prize, user: user

    expect(Redemption.first).to be_valid
  end
end