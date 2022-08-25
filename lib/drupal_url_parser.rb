# frozen_string_literal: true
class DrupalUrlParser < URLParser
  private

  def full_domain
    'https://git.drupalcode.org/project'
  end

  def tlds
    %w(org)
  end

  def domain
    'git.drupalcode'
  end

  def remove_domain
    # find the matches for any github domain characters in the url string
    # and replace only the first match incase we find a repo with something like github.com as the name
    url.sub!(/(drupalcode\.org\/project)+?(:|\/)?/i, '')
  end

  def format_url
    # if this is an Array then the url has gone through all the clean up steps
    return nil unless url.is_a?(Array) && url.length.positive?

    url.join("/")
  end
end
