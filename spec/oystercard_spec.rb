require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

  it 'has a starting balance of 0' do
    expect(oystercard.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up balance' do
      top_up_value = 5
      expect { oystercard.top_up(top_up_value) }
        .to change { oystercard.balance }.by top_up_value
    end

    it 'enforces maximum balance' do
      error = 'Maximum balance exceeded'
      top_up_value = 125
      expect { oystercard.top_up(top_up_value) }.to raise_error error
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts balance' do
      oystercard.top_up(50)
      deducted_value = 1.5
      expect { oystercard.deduct(deducted_value) }
        .to change { oystercard.balance }.by(- deducted_value)
    end
  end

  describe '#touch_in' do
    it { is_expected. to respond_to(:touch_in) }
    it 'changes the status of the card when touching in' do
      oystercard.top_up(10)
      expect(oystercard.touch_in).to be true
    end

    it 'checks minimum balance' do
      error = 'Insuficient balance'
      expect { oystercard.touch_in }.to raise_error error
    end
  end

  describe '#touch_out' do

    it { is_expected.to respond_to(:touch_out) }

    it 'changes the status of the card when touching out' do
      oystercard.top_up(10)
      oystercard.touch_in
      expect(oystercard.touch_out).to be false
    end

    it 'deducts balance when touching out' do
      oystercard.top_up(10)
      deducted_value = 1.5
      expect { oystercard.touch_out }
        .to change { oystercard.balance }.by(- deducted_value)
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }
    it 'confirms that the customer is not on a journey' do
      expect(oystercard).not_to be_in_journey
    end
  end
end
