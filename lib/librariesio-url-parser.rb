# frozen_string_literal: true

require_relative "url_parser"
require_relative "bitbucket_url_parser"
require_relative "github_url_parser"
require_relative "gitlab_url_parser"
require_relative "apache_svn_url_parser"

module LibrariesioURLParser
  VERSION = "1.0.1"
end
