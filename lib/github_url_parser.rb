# frozen_string_literal: true
class GithubURLParser < URLParser
  private

  def full_domain
    'https://github.com'
  end

  def tlds
    %w(io com org)
  end

  def domain
    'github'
  end

  def remove_domain
    # find the matches for any github domain characters in the url string
    # and replace only the first match incase we find a repo with something like github.com as the name
    url.sub!(/(github\.io|github\.com|github\.org|raw\.githubusercontent\.com)+?(:|\/)?/i, '')
  end
end
