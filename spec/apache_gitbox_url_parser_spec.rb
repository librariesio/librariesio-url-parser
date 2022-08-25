# frozen_string_literal: true

describe ApacheGitboxUrlParser do

  describe "#parse" do
    it 'parses apache gitbox urls' do
      [
        %w[https://gitbox.apache.org/repos/asf?p=camel-quarkus.git;a=summary camel-quarkus],
        %w[https://gitbox.apache.org/repos/asf/metamodel.git metamodel],
        %w[https://gitbox.apache.org/repos/asf?p=sling-org-apache-sling-testing-resourceresolver-mock.git sling-org-apache-sling-testing-resourceresolver-mock],
        %w[https://gitbox.apache.org/repos/asf?p=lucene-solr.git;f=lucene lucene-solr]
      ].each do |row|
        url, full_name = row
        result = described_class.parse(url)
        expect(result).to eq(full_name)
      end
    end
  end

  describe "#parse_to_full_url" do
    it 'parses apache gitbox urls' do
      [
        %w[https://gitbox.apache.org/repos/asf?p=camel-quarkus.git;a=summary https://gitbox.apache.org/repos/asf/camel-quarkus],
        %w[https://gitbox.apache.org/repos/asf/metamodel.git https://gitbox.apache.org/repos/asf/metamodel]
      ].each do |row|
        url, full_name = row
        result = described_class.parse_to_full_url(url)
        expect(result).to eq(full_name)
      end
    end
  end

  describe '#case_sensitive?' do
    it "the parser is case sensitive" do
      expect(described_class.case_sensitive?).to be(true)
    end
  end
end