//
//  Application.swift
//  RappiTest-iOS-Cocoapods
//
//  Created by Mario Andres Villamizar Palacio on 1/9/17.
//  Copyright © 2017 Mario Andres Villamizar Palacio. All rights reserved.
//

import Foundation
import ObjectMapper

class App: Mappable {

    var name: String?
    var images: [Image]?
    var summary: String?
    var price: Price?
    var contentType: String?
    var rights: String?
    var title: String?
    var link: String?
    var id: Id?
    var artist: String?
    var category: Category?
    var releaseDate: NSDate?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name            <- map["im:name.label"]
        images          <- map["im:image"]
        summary         <- map["summary.label"]
        price           <- map["im:price"]
        contentType     <- map["im:contentType.attributes.label"]
        rights          <- map["rights.label"]
        title           <- map["title.label"]
        link            <- map["link.attributes.href"]
        id              <- map["id"]
        artist          <- map["im:artist.label"]
        category        <- map["category"]
        releaseDate     <- (map["im:releaseDate.label"], DateTransform())
        
    }
    
    class Image: Mappable {
        
        var label: String?
        var height: Int?
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            label       <- map["label"]
            height      <- map["attributes.height"]
        }
    }
    
    class Price: Mappable {
        
        var label: String?
        var amount: Float?
        var currency: String?
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            label       <- map["label"]
            amount      <- map["attributes.amount"]
            currency    <- map["attributes.currency"]
        }
    }
    
    class Id: Mappable {
        
        var id: Int?
        var bundleId: String?
        var label: String?
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            id          <- map["attributes.im:id"]
            bundleId    <- map["attributes.im:bundleId"]
            label       <- map["label"]
        }
    }
    
    
    class Category: Mappable {
        
        var id: Int?
        var term: String?
        var scheme: String?
        
        required init?(_ map: Map) {
            
        }
        
        func mapping(map: Map) {
            id          <- map["attributes.im:id"]
            term        <- map["attributes.term"]
            scheme      <- map["attributes.scheme"]
        }
    }
    
}
