# frozen_string_literal: true

describe DrupalUrlParser do

  describe "#parse" do
    it 'parses drupal urls' do
      [
        %w[https://git.drupalcode.org/project/search_api_solr search_api_solr],
      ].each do |row|
        url, full_name = row
        result = described_class.parse(url)
        expect(result).to eq(full_name)
      end
    end
  end

  describe "#parse_to_full_url" do
    it 'parses apache svn urls' do
      [
        %w[https://git.drupalcode.org/project/search_api_solr https://git.drupalcode.org/project/search_api_solr],
      ].each do |row|
        url, full_name = row
        result = described_class.parse_to_full_url(url)
        expect(result).to eq(full_name)
      end
    end
  end

  describe '#case_sensitive?' do
    it "the parser is case insensitive" do
      expect(described_class.case_sensitive?).to be(false)
    end
  end
end