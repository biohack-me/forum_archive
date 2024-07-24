# will be used in page metadata (page titles and OpenGraph previews, etc)
SITE_TITLE = 'biohack.me forum archive'

# when showing paginated results, how many to show per page
PER_PAGE_MAX = 30

# how long to cache for, and how much wiggle room to leave to avoid cache hit
# race conditions (see: https://github.com/rails/rails/pull/44151 and
# https://api.rubyonrails.org/classes/ActiveSupport/Cache/Store.html#method-i-fetch )
CACHE_TIME = 12.hours
CACHE_TTL  = 3.minutes