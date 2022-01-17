//
//  APIParameter.swift
//  Marvel
//
//  Created by Sanket Khairnar on 07/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import Foundation

struct APIParameters {
    static var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "APIParameter", ofType: "plist") else { return "" }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else { return "" }
        return value
      }
    }
    
    static var hash: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "APIParameter", ofType: "plist") else { return "" }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "HASH") as? String else { return "" }
        return value
      }
    }
}
