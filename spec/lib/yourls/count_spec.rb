require 'spec_helper'

describe 'Yourls' do
  let(:short_url) { 'http://cbi.as/233d' }
  let(:long_url)  { 'http://giantbatfarts.com' }

  describe '.count' do
    subject { Yourls::Clicks.url(short_url) }

    it 'returns a count' do
      expect(subject).to be_a(Fixnum)
    end
  end
end

