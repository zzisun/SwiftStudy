import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark
    
    var landmarkIndex: Int {
           modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
       }
    
    var body: some View {
        VStack {
            MapView(coordinate: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
                
            
            CircleImage(image: landmark.image)
                .offset(y: -65) // Image 자체 위치
                .padding(.bottom, -55) // Image 아래 여백
            
            VStack(alignment: .leading) {
//                Text("Pepperoni Pizza")
                HStack {
                    Text(landmark.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(Color(hue: 0.346, saturation: 0.777, brightness: 0.404))
                     
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }
                
                HStack {
//                    Text("with cheese crust")
                    Text(landmark.park)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color.yellow)
                    Spacer()
//                    Text("and zero coke")
                    Text(landmark.state)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.895, brightness: 0.427))
                        
                }
                Divider()
                
//                Text("About what I want")
                Text("About \(landmark.name)")
                    .font(.title2)
//                Text("올때 페페로니핏짜")
                Text(landmark.description)
            }
            .padding()
            
            Spacer()  // push Vstack to the top
        }
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks[0])
            .environmentObject(modelData)
    }
}
