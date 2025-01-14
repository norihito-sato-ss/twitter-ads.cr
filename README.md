# twitter-ads.cr [![Build Status](https://travis-ci.org/maiha/twitter-ads.cr.svg?branch=master)](https://travis-ci.org/maiha/twitter-ads.cr)

Twitter Ads API SDK for [Crystal](http://crystal-lang.org/).

- crystal: 0.33.0

## Usage

```crystal
require "twitter-ads"

# client = TwitterAds::Client.from_twurlrc("~/.twurlrc")
client = TwitterAds::Client.new(
  CONSUMER_KEY,
  CONSUMER_SECRET,
  ACCESS_TOKEN,
  ACCESS_TOKEN_SECRET
)
client.api_version = "10" # Set this when you need a specific version
# client.api_suffix = ".json" # Set this when you need a specific suffix

accounts = client.accounts(count: 200)
accounts.req.to_s              # => "GET /8/accounts?count=200"
accounts.rate_limit            # => "1998/2000"
accounts.rate_limit.available? # => true
accounts.size                  # => 16
accounts.next_cursor?          # => nil

accounts.each do |a|
  a.id                         # => "18ce54d4x5t"
  a.name                       # => "API McTestface"

  campaigns = client.campaigns(a.id)
  campaigns.each do |c|
    c.name                     # => "batch campaigns"
```

## API

```crystal
TwitterAds::Client
  def accounts() : Api::Accounts
  def account_media(account_id : String) : Api::AccountMedia
  def authenticated_user_access(account_id : String) : AuthenticatedUserAccess
  def campaigns(account_id : String) : Api::Campaigns
  def cards(account_id : String) : Api::Cards
  def cards_all(account_id : String, card_uris : Array(String)) : Api::CardsAll
  def cards_image_app_download(account_id : String) : Api::CardsImageAppDownload
  def cards_image_conversation(account_id : String) : Api::CardsImageConversation
  def cards_image_direct_message(account_id : String) : Api::CardsImageDirectMessage
  def cards_poll(account_id : String) : Api::CardsPoll
  def cards_video_app_download(account_id : String) : Api::CardsVideoAppDownload
  def cards_video_conversation(account_id : String) : Api::CardsVideoConversation
  def cards_video_direct_message(account_id : String) : Api::CardsVideoDirectMessage
  def cards_video_website(account_id : String) : Api::CardsVideoWebsite
  def cards_website(account_id : String) : Api::CardsWebsite
  def custom_audiences(account_id : String) : Api::CustomAudiences
  def draft_tweets(account_id : String) : Api::DraftTweets
  def funding_instruments(account_id : String) : Api::FundingInstruments
  def line_items(account_id : String) : Api::LineItems
  def line_item_placements() : Api::LineItemPlacements
  def media_creatives(account_id : String) : Api::MediaCreatives
  def media_library(account_id : String) : Api::MediaLibrary
  def preroll_call_to_actions(account_id : String) : Api::PrerollCallToActions
  def promoted_accounts(account_id : String) : Api::PromotedAccounts
  def promoted_tweets(account_id : String) : Api::PromotedTweets
  def scheduled_promoted_tweets(account_id : String) : Api::ScheduledPromotedTweets
  def scheduled_tweets(account_id : String) : Api::ScheduledTweets
  def targeting_criteria(account_id : String, line_item_ids : Array(String)) : Api::TargetingCriteria
  def targeting_criteria_app_store_categories(q : String? = nil, store : String? = nil) : Api::TargetingCriteriaAppStoreCategories
  def targeting_criteria_conversations(conversation_type : String? = nil) : Api::TargetingCriteriaConversations
  def targeting_criteria_devices(q : String? = nil) : Api::TargetingCriteriaDevices
  def targeting_criteria_events(event_types : String? = nil, country_codes : String? = nil, ids : String = nil, start_time : String? = nil, end_time = String? = nil) : Api::TargetingCriteriaEvents
  def targeting_criteria_interests(q : String? = nil) : Api::TargetingCriteriaInterests
  def targeting_criteria_languages(q : String? = nil) : Api::TargetingCriteriaLanguages
  def targeting_criteria_locations(country_code = nil, location_type = nil, q = nil) : Api::TargetingCriteriaLocations
  def targeting_criteria_network_operators(country_code : String? = nil, q : String? = nil) : Api::TargetingCriteriaNetworkOperators
  def targeting_criteria_platform_versions(q : String? = nil) : Api::TargetingCriteriaPlatformVersions
  def targeting_criteria_platforms(lang : String? = nil, q : String? = nil) : Api::TargetingCriteriaPlatforms
  def targeting_criteria_tv_markets : Api::TargetingCriteriaTvMarkets
  def targeting_criteria_tv_shows(tv_market_locale : String, q : String? = nil) : Api::TargetingCriteriaTvShows
  def tweet_previews(account_id : String, tweet_type : String, tweet_ids : Array(Int64)) : Api::TweetPreviews
  def tweets(account_id : String, tweet_type : String, trim_user : Bool = false) : Api::Tweets

# Twitter API
TwitterAds::Client
  def statuses_lookup(id : String | Array(String)) : Api::StatusesLookup

TwitterAds::Response
  def rate_limit : RateLimit

TwitterAds::RateLimit
  def available? : Bool
  def limit : Int32
  def remaining : Int32
  def reset : Int32
```

`with_deleted`, `with_draft`, `count`, `cursor` argments are also available in all methods if possible.

See [src/twitter-ads/api/](./src/twitter-ads/api/) for more details.

## OAuth2

```crystal
client = TwitterAds::Client.new("CK", "CS", "AT", "AS", "BT")  # add "Bearer token" for 5th arg.
client.oauth2_standard = true  # use OAuth2 for api.twitter.com
client.oauth2_ads      = true  # use OAuth2 for ads-api.twitter.com
```

## Models

[./src/twitter-ads/models](./src/twitter-ads/models/)

## Samples

Actual usages are in [./samples/](./samples/)

## Protobuf

schema (version 2)
- [./proto/](./proto/)

generated crystal codes
- [./src/twitter-ads/proto/](./src/twitter-ads/proto/)

Protobuf-related files are not read by default.
To use it, you need to install [protobuf.cr](https://github.com/jeromegn/protobuf.cr) and require above codes.

```crystal
require "protobuf"
require "twitter-ads/proto"
```

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  twitter-ads:
    github: maiha/twitter-ads.cr
    version: 12.2.0
```

## Development

```console
$ crystal spec
```

## NOTE
- The `cards` API uses the external UNIX command `jq`.
- media_library: `media_id` returns String (document says `Type: long`)
- targeting-criteria: `targeting_value` sometimes returns 0 (Integer).

## Roadmap

- Analytics
  - [ ] Asynchronous Analytics
  - [ ] Reach and Average Frequency
  - [x] Synchronous Analytics
  - [ ] Auction Insights
  - [ ] Active Entities
- Audiences
  - [ ] Insights
  - [ ] Keyword Insights
  - [ ] Tailored Audience Permissions
  - [ ] Tailored Audiences
  - [ ] Audience Intelligence
  - [ ] Tailored Audiences Users
- Campaign Management
  - [x] Accounts
  - [x] Authenticated User Access
  - [ ] Bidding Rules
  - [x] Campaigns
  - [ ] Content Categories
  - [ ] Features
  - [x] Funding Instruments
  - [ ] IAB Categories
  - [x] Line Items
  - [x] Line Item Placements
  - [x] Media Creatives
  - [x] Promoted Accounts
  - [x] Promoted Tweets
  - [x] Promotable Users
  - [ ] Reach Estimate
  - [x] Scheduled Promoted Tweets
  - [x] Targeting Criteria
  - [ ] Targeting Options
    - [x] App Store Categories
    - [x] Conversation
    - [x] Devices
    - [x] Events
    - [x] Interests
    - [x] Languages
    - [x] Locations
    - [x] Network Operators
    - [x] Platform Versions
    - [x] Platforms
    - [x] TV Markets
    - [x] TV Shows
  - [ ] Targeting Suggestions
  - [ ] Tax Settings
  - [ ] User Settings
- Creatives
  - [x] Account Media
  - [x] Image App Download Cards
  - [x] Image Conversation Cards
  - [x] Scheduled Tweets
  - [x] Video App Download Cards
  - [x] Video Conversation Cards
  - [x] Video Website Cards
  - [x] Website Cards
  - [x] Preroll Call To Actions
  - [x] Tweets
  - [x] Image Direct Message Cards
  - [x] Video Direct Message Cards
  - [x] Media Library
  - [x] Cards Fetch
  - [x] Poll Cards
  - [x] Draft Tweets
  - [x] Tweet Previews
  - [x] Tweets
- Measurement
  - [ ] App Event Provider Configurations
  - [ ] App Event Tags
  - [ ] Web Event Tags
  - [ ] App Lists
  - [ ] Conversion Attribution
  - [ ] Conversion Event
- Twitter API
  - [x] GET statuses/lookup

## Breaking changes

#### v11
* [CHANGED] `user_id` in `authenticated_user_access` changed from int64 to string
* [CHANGED] `id` in `draft_tweets` changed from int64 to string
* [CHANGED] `advertiser_user_id` in `line_item`  changed from int64 to string
* [DEPRECATED] `cards_image_app_download`
* [DEPRECATED] `cards_image_direct_message`
* [DEPRECATED] `cards_video_app_download`
* [DEPRECATED] `cards_video_direct_message`
* [DEPRECATED] `cards_video_website`
* [DEPRECATED] `cards_website`

#### v10
* [DEPRECATED] `tracking_tags` parameter on `line_items` (use `tracking_tag` instead)

#### v9
* [DEPRECATED] `line_item_apps` (use `line_item` instead)

#### v7
* [DEPRECATED] `id` parameter on `targeting_criteria/events`
* [DEPRECATED] `id` parameter on `targeting_criteria/tv_markets`

#### v6
* [REMOVED] `scoped_timeline`
* [REMOVED] `targeting_criteria/behaviors`
* [CHANGED] `locale` is a required parameter on `targeting_criteria/tv_shows`

## Contributing

1. Fork it (<https://github.com/maiha/twitter-ads.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) - creator, maintainer
- Special thanks to OSS
  - specification is derived from [twitter-ruby-ads-sdk](https://github.com/twitterdev/twitter-ruby-ads-sdk) (MIT)
  - implementaion is derived from [twitter-crystal](https://github.com/sferik/twitter-crystal) (Apache License 2.0)
