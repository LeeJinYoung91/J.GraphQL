//
//  Network.swift
//  J.UserManagerment
//
//  Created by JinYoung Lee on 2020/03/02.
//  Copyright © 2020 JinYoung Lee. All rights reserved.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:3000/graphql")!)
}
