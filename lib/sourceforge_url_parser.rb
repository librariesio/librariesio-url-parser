# frozen_string_literal: true
class SourceforgeUrlParser < URLParser
  PROJECT_PATHS = %w[projects p].freeze

  private

  def full_domain
    'https://sourceforge.net/projects'
  end

  def tlds
    %w(net)
  end

  def domain
    'sourceforge'
  end

  def remove_domain
    url.sub!(/(sourceforge\.net\/(#{PROJECT_PATHS.join("|")}))+?(:|\/)?/i, '')
  end

  def extractable_early?
    false
  end

  def remove_extra_segments
    self.url = url.split('/').reject{ |s| s.strip.empty? }.first
  end

  def format_url
    # the URL at this point should have been reduced down to a single string for the project name
    return nil unless url.is_a?(String)

    url
  end
end
