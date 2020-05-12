// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tweetData = try? newJSONDecoder().decode(TweetData.self, from: jsonData)

import Foundation


struct TweetData {
    let tweetData : [TweetDatum]
}

// MARK: - TweetDatum
struct TweetDatum: Codable {
    let  text: String
    
    let user: TwitterUser
    
    
    enum CodingKeys: String, CodingKey {
        
        case text = "full_text"
        case user
    }
}

struct TwitterUser:Codable {
    let profileImageURL: String
    let  screenName: String
    let profileImageURLHTTPS: String
    let name: String
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        
        case profileImageURL = "profile_image_url"
        
        case screenName = "screen_name"
        
        case profileImageURLHTTPS = "profile_image_url_https"
        
        case name, url
        
    }
}
