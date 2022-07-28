# frozen_string_literal: true
class EclipseGitUrlParser < URLParser
  private

  def full_domain
    'https://git.eclipse.org/c'
  end

  def tlds
    %w(org)
  end

  def domain
    'git.eclipse'
  end

  def remove_git_extension
    # the repository names all end in .git on the website, so don't remove it here
    nil
  end

  def remove_domain
    url.sub!(/(eclipse\.org\/c)+?(:|\/)?/i, '')
  end
end
