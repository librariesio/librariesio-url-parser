# frozen_string_literal: true

describe ApacheSvnUrlParser do

  describe "#parse" do
    it 'parses apache svn urls' do
      [
        %w[http://svn.apache.org/viewvc/stanbol/tags/apache-stanbol-1.0.0/ stanbol],
        %w[http://svn.apache.org/viewvc/maven/pom/tags/apache-7 maven/pom/tags/apache-7],
        %w[http://svn.apache.org/viewvc/maven/pom/tags/apache-16/ignite-parent/ignite-zookeeper maven/pom/tags/apache-16]
      ].each do |row|
        url, full_name = row
        result = described_class.parse(url)
        expect(result).to eq(full_name)
      end
    end

    it "doesn't parse the Apache repos URL" do
      url = "scm:svn:https://svn.apache.org/repos/asf/stanbol/tags/apache-stanbol-1.0.0/release-1.0.0-branch/stanbol.apache.org"
      expect(described_class.parse(url)).to be_nil
    end
  end

  describe "#parse_to_full_url" do
    it 'parses apache svn urls' do
      [
        %w[https://svn.apache.org/viewvc/stanbol/tags/apache-stanbol-1.0.0/ https://svn.apache.org/viewvc/stanbol],
        %w[http://svn.apache.org/viewvc/maven/pom/tags/apache-7 https://svn.apache.org/viewvc/maven/pom/tags/apache-7],
        %w[http://svn.apache.org/viewvc/maven/pom/tags/apache-16/ignite-parent/ignite-zookeeper https://svn.apache.org/viewvc/maven/pom/tags/apache-16]
      ].each do |row|
        url, full_name = row
        result = described_class.parse_to_full_url(url)
        expect(result).to eq(full_name)
      end
    end
  end
end
