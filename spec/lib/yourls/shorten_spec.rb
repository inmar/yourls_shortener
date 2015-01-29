require 'spec_helper'

describe 'Yourls' do
  let(:long_url)     { 'http://giantbatfarts.com' }
  let(:short_url)    { 'http://examp.le/123a' }
  let(:api_endpoint) { domain + '/yourls-api.php' }
  let(:domain)       { 'http://example.com' }

  before { VCR.insert_cassette('shorten', record: :new_episodes) }
  after  { VCR.eject_cassette('shorten') }

  describe '.shorten' do
    subject { Yourls::Shorten.url(long_url) }

    it 'returns the short url' do
      expect(subject).to include("examp.le")
    end

    context 'when the url contains params' do
      let(:long_url)  { 'http://giantbatfarts.com/api?action=fartharder' }
      let(:params) { {} }
      subject { Yourls::Shorten.url(long_url) }

      it 'calls RestClient with the expected params' do
        allow(RestClient).to receive(:get).with(params)
        subject
        expect(RestClient).to have_received(params)
      end

      it 'returns the short url' do
        expect(subject).to include("examp.le")
      end
    end
  end
end
