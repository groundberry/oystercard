require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }
  let(:station) { double :station }

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

  describe '#touch_in_balance' do
    it { is_expected. to respond_to(:touch_in_balance) }

    it 'checks minimum balance' do
      error = 'Insuficient balance'
      expect { oystercard.touch_in_balance }.to raise_error error
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it 'deducts balance when touching out' do
      oystercard.top_up(10)
      expect { oystercard.touch_out }
        .to change { oystercard.balance }.by(- Oystercard::MIN_CHARGE)
    end
  end
end
