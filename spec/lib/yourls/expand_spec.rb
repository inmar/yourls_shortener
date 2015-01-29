require 'spec_helper'

describe 'Yourls' do
  let(:short_url) { 'http://cbi.as/233d' }
  let(:long_url)  { 'http://giantbatfarts.com' }

  describe '.expand' do
    subject { Yourls::Expand.url(short_url) }

    it 'returns the long url' do
      expect(subject).to eq(long_url)
    end
  end
end
