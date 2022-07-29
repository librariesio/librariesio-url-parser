# frozen_string_literal: true

describe SourceforgeUrlParser do

  describe '#parse' do
    it 'parses sourceforge urls' do
      [
        %w[https://sourceforge.net/projects/libpng libpng],
        %w[https://sourceforge.net/p/libpng/code/ci/master/tree/ci libpng]
      ].each do |row|
        url, full_name = row
        result = described_class.parse(url)
        expect(result).to eq(full_name)
      end
    end
  end

  describe '#parse_to_full_url' do
    it 'parses sourceforge git urls' do
      [
        %w[https://sourceforge.net/projects/libpng https://sourceforge.net/projects/libpng],
        %w[https://sourceforge.net/p/libpng/code/ci/master/tree/ci/ https://sourceforge.net/projects/libpng]
      ].each do |row|
        url, full_name = row
        result = described_class.parse_to_full_url(url)
        expect(result).to eq(full_name)
      end
    end
  end
end