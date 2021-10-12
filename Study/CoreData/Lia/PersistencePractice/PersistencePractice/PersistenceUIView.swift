//
//  PersistenceUIView.swift
//  PersistencePractice
//
//  Created by Lia on 2021/10/12.
//

import SwiftUI

struct PersistenceUIView: View {
    @State var clickCheck = false
    @State var name = ""
    @State var email = ""
    @State var profileImage = ""
    @State var id = ""
    @State var users = [User]()
    
    var body: some View {
        VStack {
            Text("Core Data Test")
            
            VStack {
                TextField("write user name", text: $name)
                TextField("write user email", text: $email)
                TextField("write user image", text: $profileImage)
            }
            .padding(30)
            
            Button(action: {
                let user = User(id: 0, name: name, email: email, profileImage: profileImage)
                PersistenceManager.shared.save(user: user)
                users = PersistenceManager.shared.fetchUsers()
            }) {
                Text("Save")
            }
            
            Text("delete first user")
                .padding(30)
            
            Button(action: {
                PersistenceManager.shared.deleteUser(id: 0)
                users = PersistenceManager.shared.fetchUsers()
            }) {
                Text("Delete")
            }
            
            Text(arr2String(arr: users))
        }

    }
}

struct PersistenceUIView_Previews: PreviewProvider {
    static var previews: some View {
        PersistenceUIView()
    }
}

func arr2String<T>(arr: [T]) -> String {
    var result = ""
    arr.forEach {
        result += "\($0)\n"
    }
    return result
}
