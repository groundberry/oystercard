require 'station'

describe Station do
  subject(:station) { described_class.new('Waterloo', 1) }

  it 'gives the name of the station' do
    expect(station.name).to eq 'Waterloo'
  end

  it 'gives the zone of the station' do
    expect(station.zone).to eq 1
  end
end
