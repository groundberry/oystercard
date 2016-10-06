require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:oystercard) { double :oystercard }

  it 'should have an empty list of jurneys by default' do
    expect(subject.journey_history).to be_empty
  end

  describe '#journey_start' do
    it { is_expected. to respond_to(:journey_start).with(1).argument }

    it 'changes the status of the card when touching in' do
      expect(subject.journey_start(station)).to be true
    end

    it 'record entry station' do
      subject.journey_start(station)
      expect(subject.entry_station).to eq station
    end
  end
  describe '#journey_finish' do
    it { is_expected.to respond_to(:journey_finish).with(1).argument }
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

    it 'changes the status of the card when touching out' do
      subject.journey_start(station)
      expect(subject.journey_finish(station)).to be false
    end

    it 'stores exit station' do
      subject.journey_start(station)
      subject.journey_finish(station)
      expect(subject.exit_station).to eq station
    end

    let(:journey) { { entry_station: station, exit_station: station } }

    it 'stores a journey' do
      subject.journey_start(station)
      subject.journey_finish(station)
      expect(subject.history).to include journey
    end
  end

  describe '#journey_complete?' do
    it { is_expected.to respond_to(:journey_complete?) }
    it 'confirms that the customer is not on a journey' do
      expect(subject).to be_journey_complete
    end
  end
end
