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

  it 'does not parse sourceforge.jp urls' do
    expect(described_class.parse_to_full_url("http://svn.sourceforge.jp/svnroot/foo/")).to be_nil
  end

  describe '#case_sensitive?' do
    it "the parser is case insensitive" do
      expect(described_class.case_sensitive?).to be(false)
    end
  end
end
