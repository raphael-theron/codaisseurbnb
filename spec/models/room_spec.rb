require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:home_type) }
    it { is_expected.to validate_presence_of(:room_type) }
    it { is_expected.to validate_presence_of(:accommodate) }
    it { is_expected.to validate_presence_of(:bedroom_count) }
    it { is_expected.to validate_presence_of(:bathroom_count) }
    it { is_expected.to validate_presence_of(:listing_name) }
    it { is_expected.to validate_length_of(:listing_name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(500) }
    it { is_expected.to validate_presence_of(:address) }
  end
end

describe "#bargain?" do
    let(:bargain_room) { create :room, price: 20 }
    let(:non_bargain_room) { create :room, price: 200 }

    it "returns true if the price is smaller than 30 EUR" do
      expect(bargain_room.bargain?).to eq(true)
      expect(non_bargain_room.bargain?).to eq(false)
    end
  end

  describe ".order_by_price" do
  let!(:room1) { create :room, price: 100 }
  let!(:room2) { create :room, price: 200 }
  let!(:room3) { create :room, price: 50 }

  it "returns a sorted array of rooms by prices" do
    # note that they should not come out in the order that they were created
    expect(Room.order_by_price).to eq([room3, room1, room2])
  end
end



end
