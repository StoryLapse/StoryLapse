//
//  api.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/26/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation
import Alamofire

func api(
  method: Alamofire.Method,
  _ path: String,
  query: [String: AnyObject]? = nil,
  body: [String: AnyObject]? = nil) -> Alamofire.Request {
    typealias PE = Alamofire.ParameterEncoding
    let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "http://103.47.192.73:2292/api/v1\(path)")!)
    let encodedURLRequest = PE.JSON.encode(
      PE.URLEncodedInURL.encode(mutableURLRequest, parameters: query).0,
      parameters: body).0
    
    encodedURLRequest.HTTPMethod = method.rawValue

    return Alamofire.request(encodedURLRequest)
}