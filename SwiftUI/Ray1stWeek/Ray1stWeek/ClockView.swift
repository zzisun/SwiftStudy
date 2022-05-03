//
//  ClockView.swift
//  Ray1stWeek
//
//  Created by wooseok.suh on 2022/05/03.
//

import SwiftUI

struct ClockView: View {
    @State var center: String = "Center"
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 20) {
                Text("11")
                Text("9")
                Text("7")
            }
            
            VStack(alignment: .center, spacing: 20) {
                Text("12")
                Text("\(center)")
                    .fontWeight(.medium)
                Text("6")
            }
            
            VStack(alignment: .center, spacing: 20) {
                Text("1")
                Text("3")
                Text("5")
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
