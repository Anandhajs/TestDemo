//
//  TestModel.swift
//  TestDemo
//
//  Created by Sparkout on 06/06/23.
//

import Foundation
import UIKit

struct NearByRestaurantsResponse: Codable {
    let status: Bool?
    let restaurants: [Restaurant]?
}

struct Restaurant: Codable {
    var restaurantID: UInt64?
    var restaurantName: String?
    var image: String?
 
    enum CodingKeys: String, CodingKey {
        case restaurantID = "id"
        case image
        case restaurantName = "name"
    }
}

