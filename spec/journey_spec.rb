require 'journey'

describe Journey do
  let(:station) { double :station }

  describe '#start' do
    it { is_expected. to respond_to(:start).with(1).argument }

    it 'record entry station' do
      subject.start(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#finish' do
    it { is_expected.to respond_to(:finish).with(1).argument }

    it 'stores exit station' do
      subject.finish(station)
      expect(subject.exit_station).to eq station
    end
  end

  describe 'fare' do
    it { is_expected.to respond_to(:fare) }

    it 'charges the minimum fare if journey is complete' do
      subject.start(station)
      subject.finish(station)
      expect(subject.fare).to eq Journey::MIN_CHARGE
    end

    it 'charges a penalty fare if the journey has not started' do
      subject.finish(station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'charges a penalty fare if the journey has not finished' do
      subject.start(station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end
end
