//
//  Article.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/23/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import Foundation

struct Article: Codable {
    var url: String
    var title: String
    var abstract: String
    var published_date : String
    var urlImage: String
    
    init(dictionary: Dictionary <String, Any>){
        url = dictionary["url"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        abstract = dictionary["abstract"] as? String ?? ""
        published_date = dictionary["published_date"] as? String ?? ""
        
      urlImage = ((dictionary["media"] as? [Dictionary<String, Any>] ?? []).first?["media-metadata"] as? [Dictionary<String, Any>] ?? [])[2]["url"] as? String ?? ""
        
    }

}
