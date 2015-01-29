require 'spec_helper'

describe 'Yourls' do
  let(:short_url) { 'http://cbi.as/233d' }
  let(:long_url)  { 'http://giantbatfarts.com' }

  describe '.shorten' do
    subject { Yourls::Shorten.url(long_url) }

    it 'returns the long url' do
      expect(subject).to eq(short_url)
    end
  end
end
