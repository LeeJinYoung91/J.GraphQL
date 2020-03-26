//
//  UserListCell.swift
//  J.UserManagerment
//
//  Created by JinYoung Lee on 2020/03/24.
//  Copyright © 2020 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class UserListCell: UITableViewCell {
    @IBOutlet weak var nameTab: UILabel?
    @IBOutlet weak var ageTab: UILabel?
    @IBOutlet weak var genderTab: UILabel?
    
    func setUp(user: User) {
        nameTab?.text = user._name
        ageTab?.text = String(format: "%d", user._age ?? 0)
        genderTab?.text = user._gender
    }
}
