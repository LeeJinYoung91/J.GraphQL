//
//  User.swift
//  J.UserManagerment
//
//  Created by JinYoung Lee on 2020/02/28.
//  Copyright © 2020 JinYoung Lee. All rights reserved.
//

import Foundation

class User {
    let _id: String!
    var _name: String?
    var _age: Int?
    var _gender: String?
    
    init(id: String, name: String?, age: Int?, gender: String?) {
        _id = id
        _name = name
        _age = age
        _gender = gender
    }
}
