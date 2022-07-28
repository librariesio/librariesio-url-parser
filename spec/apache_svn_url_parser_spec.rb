# frozen_string_literal: true

describe ApacheSvnUrlParser do

  describe "#parse" do
    it 'parses apache svn urls' do
      [
        %w[http://svn.apache.org/viewvc/stanbol/tags/apache-stanbol-1.0.0/ stanbol],
        %w[http://svn.apache.org/viewvc/maven/pom/tags/apache-7 maven/pom/tags/apache-7],
        %w[http://svn.apache.org/viewvc/maven/pom/tags/apache-16/ignite-parent/ignite-zookeeper maven/pom/tags/apache-16],
        %w[http://svn.apache.org/viewcvs.cgi/portals/pluto/tags/pluto-1.1.7 portals/pluto],
        %w[scm:svn:https://svn.apache.org/repos/asf/stanbol/tags/apache-stanbol-1.0.0/release-1.0.0-branch/stanbol.apache.org stanbol],
        %w[https://svn.apache.org/repos/asf/maven/wagon/tags/wagon-1.0-beta-2 maven/wagon]
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
