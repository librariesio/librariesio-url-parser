# frozen_string_literal: true
class BitbucketURLParser < URLParser
  private

  def full_domain
    'https://bitbucket.org'
  end

  def tlds
    %w(com org)
  end

  def domain
    'bitbucket'
  end

  def remove_domain
    # find the matches for any github domain characters in the url string
    # and replace only the first match incase we find a repo with something like github.com as the name
    url.sub!(/(bitbucket\.com|bitbucket\.org)+?(:|\/)?/i, '')
  end
end
