require 'spec_helper'

describe 'Yourls' do
  let(:short_url) { 'http://examp.le/123a' }
  let(:long_url)  { 'http://giantbatfarts.com' }

  before { VCR.insert_cassette('expand', record: :new_episodes) }
  after  { VCR.eject_cassette('expand') }

  describe '.expand' do
    subject { Yourls::Expand.url(short_url) }

    it 'returns the long url' do
      expect(subject).to eq(long_url)
    end
  end
end
