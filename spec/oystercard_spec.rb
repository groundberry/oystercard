require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new(10) }
  subject(:oystercard2) {Oystercard.new}
  let(:station) { double :station }

  def make_journey
    oystercard.touch_in(station)
    oystercard.touch_out(station)
  end

  it 'has a starting balance of 0' do
    expect(oystercard2.balance).to eq(0)
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

  describe '#touch_in' do
    it { is_expected. to respond_to(:touch_in).with(1).argument }

    it 'checks minimum balance' do
      error = 'Insuficient balance'
      expect { oystercard2.touch_in(station) }.to raise_error error
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'deducts balance when touching out' do
      oystercard.touch_in(station)
      expect { oystercard.touch_out(station) }
        .to change { oystercard.balance }.by(- Oystercard::MIN_CHARGE)
    end

    it 'saves the journey in journey history' do
      make_journey
      expect(oystercard.journey_history).to_not be_empty
    end

    it 'doesn\'t charge twice' do
      make_journey
      expect { oystercard.touch_out(station) }
        .to change { oystercard.balance }.by 0
    end
  end

  context 'incomplete journeys' do
    it 'charges a penalty fare if not touched in' do
      expect { oystercard.touch_out(station) }
        .to change { oystercard.balance }.by(- Oystercard::PENALTY_FARE)
    end

    it 'charges a penalty fare if not touched out' do
      oystercard.touch_in(station)
      expect { oystercard.touch_in(station) }
        .to change { oystercard.balance }.by(- Oystercard::PENALTY_FARE)
    end

    it 'doesn\'t charge a penalty fare when touching in for the first time' do
      make_journey
      expect { oystercard.touch_in(station) }
        .to change { oystercard.balance }.by 0
    end

    it "deducts penalty if entry station wasn't logged" do
      expect{
        oystercard.touch_out(station)
        make_journey
      }.to change{oystercard.balance}.by(-(Journey::PENALTY_FARE+Journey::MIN_CHARGE))
    end

    it "doesn't double charge the user" do
      expect{
        3.times do
          make_journey
        end
      }.to change{oystercard.balance}.by(-Journey::MIN_CHARGE*3)
    end
  end
end
