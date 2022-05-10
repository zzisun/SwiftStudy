//
//  ContentView.swift
//  Ray2ndWeek
//
//  Created by wooseok.suh on 2022/05/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: ButtonView()) {
                    Text("Go to ButtonView")
                        .padding()
                }
                
                NavigationLink(destination: ListView()) {
                    Text("Show Names of Study Members")
                        .padding()
                }
                
                NavigationLink(destination: PickerView()) {
                    Text("Picker View")
                        .padding()
                }
                
                NavigationLink(destination: ModifiedView()) {
                    Text("ViewModifier")
                        .padding()
                }
            }.navigationBarTitle(Text("Home"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
