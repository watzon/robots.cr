# robots.cr

Simple robots.txt parsing for Crystal

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     robots:
       github: watzon/robots
   ```

2. Run `shards install`

## Usage

```crystal
require "robots"

# From reddit
robotstxt = <<-TEXT
# 80legs
User-agent: 008
Disallow: /

User-Agent: *
Disallow: /goto
Disallow: /*after=
Disallow: /*before=
Disallow: /domain/*t=
Disallow: /login
Disallow: /reddits/search
Disallow: /search
Disallow: /r/*/search
Allow: /
TEXT

reddit = Robots.new(robotstxt, "Googlebot")

reddit.allowed?("/login")
# => false

reddit.allowed?("/r/SushiChain")
# => true

reddit.allowed?("/r/SushiChain/search")
# => false
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com /robots/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Watson](https://github.com/watzon) - creator and maintainer
