//
//  ServicesBase.swift
//  IDDog
//
//  Created by Marcos Lacerda on 25/09/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import Foundation
import Alamofire

internal class ServicesBase: NSObject {
  
  // MARK: - Commom attributes
  
  /// Define the `default` headers to send the service
  internal var headers: HTTPHeaders = ["Content-Type": "application/json"]
  
  /// Define the encoder to using in parse parameters
  internal let encoder = JSONEncoding()

  /// Define the decoder to using in parse models
  internal let decoder = JSONDecoder()

  // MARK: - Commom methods
  
  func appendAuthorizationHeaders() {
    headers["Authorization"] = ApplicationSession.loggedUser.token
  }

  func parseError(_ response: Data?, error: Error) -> String {
    if error._code == NSURLErrorTimedOut {
      return "timeout-error".localized()
    }
    
    guard let data = response, let responseError = try? JSONDecoder().decode(ServiceError.self, from: data) else {
      return error.localizedDescription
    }

    return responseError.error.message
  }
  
  func makeURL(_ operation: APIOperations) -> URL {
    let baseURL = SecurityManager.shared.reveal(Constants.kBaseURL)

    let fullURL = String(format: "%@%@", baseURL, operation.rawValue)

    guard let url = URL(string: fullURL) else {
      fatalError("Error to handler base url to a URL")
    }

    return url
  }
}
