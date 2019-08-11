module TwitterAds::Api
  class CardsVideoWebsite < TwitterAds::Response
    resource_collection CardsVideoWebsite

    belongs_to account_id : String
  end
end

class TwitterAds::Client
  def cards_video_website(account_id : String, count : Int32 = 200, cursor : String = "") : Api::CardsVideoWebsite
    res = get("/5/accounts/#{account_id}/cards/video_website.json", {"count" => count.to_s, "cursor" => cursor})
    Api::CardsVideoWebsite.new(res, account_id: account_id)
  end
end