# frozen_string_literal: true
class GitlabURLParser < URLParser
  private

  def full_domain
    'https://gitlab.com'
  end

  def tlds
    %w(com)
  end

  def domain
    'gitlab'
  end

  def remove_domain
    # find the matches for any github domain characters in the url string
    # and replace only the first match incase we find a repo with something like github.com as the name
    url.sub!(/(gitlab\.com)+?(:|\/)?/i, '')
  end
end
