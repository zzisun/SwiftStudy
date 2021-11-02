//
//  User.swift
//  RealmWidget
//
//  Created by Lia on 2021/11/02.
//

import Foundation

struct User : Decodable {
    var id: Int
    var name: String
    var email: String
    var profileImage: String
}
