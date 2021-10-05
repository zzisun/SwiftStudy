//
//  User.swift
//  SimpleWidget
//
//  Created by Lia on 2021/10/05.
//

import Foundation
import WidgetKit

struct User: Decodable, TimelineEntry {
    let id: Int
    let email: String
    let name: String
    let profileImage: String
}
