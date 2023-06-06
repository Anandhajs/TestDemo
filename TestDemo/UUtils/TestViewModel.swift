//
//  TestViewModel.swift
//  TestDemo
//
//  Created by Sparkout on 05/06/23.
//

import Foundation
import UIKit

enum DataError: Error {
    case invalidURL
    case NoData
}

struct TestViewModel {
    static let shared = TestViewModel()
    let urlSession = URLSession.shared
    
    func responseDetails(completion: @escaping([Restaurant]?, Error?) -> Void) {
        guard let url: URL = URL(string: "https://reloadsample.free.beeceptor.com/") else {
            return
        }
        let task = urlSession.dataTask(with: url) { data, _, error in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(NearByRestaurantsResponse.self, from: dataResponse)
                completion(result.restaurants, nil)
            } catch{
                print("Error", error.localizedDescription)
            }
        }
        task.resume()
    }
}
