//
//  PickerView.swift
//  Ray2ndWeek
//
//  Created by wooseok.suh on 2022/05/10.
//

import SwiftUI

struct PickerView: View {
    @State private var currentIndex = 0
    @State private var showText = false
    @State private var names = ["A", "B", "C"]
    @State private var status = ["매우 피곤한 상태", "많이 피곤한 상태", "심하게 피곤한 상태"]
    var body: some View {
        Form {
            Section {
                Picker("", selection: $currentIndex) {
                    ForEach( 0 ..< names.count ) {
                        index in
                        Text("\(self.names[index])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Toggle(isOn: $showText) {
                    Text("Show Current Page")
                }
                if showText {
                    Text("Current Page: \(names[currentIndex])")
                }
            }
            
            Section {
                Text("\(status[currentIndex])")
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
