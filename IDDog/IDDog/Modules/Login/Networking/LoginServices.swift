//
//  LoginServices.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

typealias LoginServicesCallback = ((Result<User>) -> Void)

class LoginServices: ServicesBase {
  
  public static let shared = LoginServices()

  internal override init() {}
  
  // MARK: - Private keys
  
  internal enum ParamKeys: String {
    case email = "email"
  }
  
  // MARK: - Public methods
  
  internal func performLogin(_ email: String, handler: @escaping LoginServicesCallback) {
    let url = self.makeURL(.login)
    let params: [String: Any] = [ParamKeys.email.rawValue: email]
    
    Alamofire.request(url, method: .post, parameters: params, encoding: encoder, headers: headers).responseDecodableObject(keyPath: "user", decoder: decoder) { (response: DataResponse<User>) in

      switch response.result {
      case .success(let user):
        handler(.success(user))
        
      case .failure(let error):
        let errorMessage = self.parseError(response.data, error: error)
        handler(.error(errorMessage))
      }

    }
  }

}
