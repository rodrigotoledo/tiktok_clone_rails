# TikTok Clone (Rails + Turbo)

Just a TikTok clone using Rails, broadcasting, and comments with real-time.

## Stack

- **Ruby on Rails 8**
- **Turbo Streams** + **Solid Cable** (Action Cable over Solid)
- **Tailwind CSS** (`tailwindcss-rails` gem; no Node required)
- **SQLite3** (development & test)

## Features

- Infinite-style feed for posts (Photo/Video)
- Real-time comments via Turbo Streams over **Solid Cable**
- Hotwire-friendly partials for fast UI updates
- Minimal setup using **SQLite3** and **Tailwind** pipeline

## Requirements

- Ruby 3.3+ (recommended 3.4.x)
- Bundler
- SQLite3

Start with

```bash
bin/dev_local
```
