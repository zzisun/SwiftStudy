//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by 김지선 on 2021/08/31.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button(action: {
            isSet.toggle()
        }){
            Image(systemName: isSet ? "heart.fill" : "heart")
                .foregroundColor(.red)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
