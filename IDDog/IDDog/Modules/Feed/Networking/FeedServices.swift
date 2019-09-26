//
//  FeedServices.swift
//  IDDog
//
//  Created by Marcos Lacerda on 26/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

typealias FeedServicesCallback = ((Result<Pets>) -> Void)

class FeedServices: ServicesBase {
  
  public static let shared = FeedServices()

  internal override init() {}
  
  // MARK: - Private keys
  
  internal enum ParamKeys: String {
    case category = "category"
  }
  
  // MARK: - Public methods
  
  internal func fetchFeed(_ category: FeedCategories = .husky, handler: @escaping FeedServicesCallback) {
    let url = self.makeURL(.fetchFeed)
    let params: [String: Any] = [ParamKeys.category.rawValue: category.rawValue]
    
    // Add authorization headers
    self.appendAuthorizationHeaders()
    
    Alamofire.request(url, method: .get, parameters: params, headers: headers).responseDecodableObject(decoder: decoder) { (response: DataResponse<Pets>) in

      switch response.result {
      case .success(let pets):
        handler(.success(pets))
        
      case .failure(let error):
        let errorMessage = self.parseError(response.data, error: error)
        handler(.error(errorMessage))
      }

    }
  }
  
  // MARK: - Tests methods
  
  internal func fetchMockFeed(_ category: FeedCategories = .husky, shouldBeFail: Bool = false, handler: @escaping FeedServicesCallback) {
    if !shouldBeFail {
      let fileName = "\(category)"

      guard let path = Bundle.main.path(forResource: fileName, ofType: "json"), let content = try? String(contentsOfFile: path), let data = content.data(using: .utf8), let pets = try? decoder.decode(Pets.self, from: data) else {
        handler(.error("Categorie resource not found"))
        return
      }

      handler(.success(pets))
    } else {
      handler(.error("Feed not avaliable now"))
    }
  }

}
