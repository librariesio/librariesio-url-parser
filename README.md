# Libraries.io URL Parser

Repository URL parsing library for https://libraries.io

## Usage

Parse a org/repo string from an input string:

```ruby
GithubURLParser.parse("https://github.com/rails/rails/") #=> rails/rails
GithubURLParser.parse("git@github.com:rails/rails.git") #=> rails/rails
GithubURLParser.parse("https://github.com/rails/rails.git") #=> rails/rails
GithubURLParser.parse("https://github.com") #=> nil
```

Parse a full url from an input string:

```ruby
GithubURLParser.parse_to_full_url("https://github.com/rails/rails/") #=> https://github.com/rails/rails
GithubURLParser.parse_to_full_url("git@github.com:rails/rails.git") #=> https://github.com/rails/rails
GithubURLParser.parse_to_full_url("https://github.com/rails/rails.git") #=> https://github.com/rails/rails
GithubURLParser.parse_to_full_url("https://github.com") #=> nil
```

Parse an org/user url from an input string:

```ruby
GithubURLParser.parse_to_full_user_url("https://github.com/rails/rails/") #=> nil
GithubURLParser.parse_to_full_user_url("git@github.com:rails/rails.git") #=> nil
GithubURLParser.parse_to_full_user_url("https://github.com/rails/rails.git") #=> nil
GithubURLParser.parse_to_full_user_url("https://github.com") #=> nil
GithubURLParser.parse_to_full_user_url("https://github.com/rails") #=> https://github.com/rails
```

Parse a full url from an input string where the repository is unknown

```ruby
URLParser.try_all("git@github.com:rails/rails.git") #=> https://github.com/rails/rails
URLParser.try_all("git@gitlab.com:inkscape/inkscape.git") #=> "https://gitlab.com/inkscape/inkscape"
URLParser.try_all("git@bitbucket.org:tildeslash/monit.git") #=> "https://bitbucket.org/tildeslash/monit"
```

## Supported repositories

- GitHub
- GitLab
- Bitbucket
- Apache SVN

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/librariesio/librariesio-url-parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

