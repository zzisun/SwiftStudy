//
//  User.swift
//  RealmWidget
//
//  Created by Lia on 2021/11/02.
//

import Foundation
import RealmSwift

class User : Object, Decodable {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var profileImage: String
}
