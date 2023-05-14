import SwiftUI

struct TitleView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
            Spacer()
            Button(action:{}) {
                Image(systemName: "line.3.horizontal")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
        }
        .padding(50)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "TO-DO LIST")
    }
}
