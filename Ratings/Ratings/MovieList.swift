//
//  ContentView.swift
//  Ratings
//
//  Created by yucian huang on 2024/9/28.
//

import SwiftUI

struct MovieList: View { // pretens from api
    var movieData: [Movie] = [
        Movie(title: "Bone tomahawh", sexy: true, ratings: 4.3),
        Movie(title: "Cars", sexy: false, ratings: 3.1),
        Movie(title: "inception", sexy: true, ratings: 1.7)
    ]
    
// from API
struct Movie: Identifiable  { // hashable gives random id
    var id = UUID() // automatically trackable
    var title: String
    var sexy: Bool
    var ratings: Double //4.6
}
    
    @State var movieList: [MovieRender] = []
    var starTiers = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5]
    
// for UI
struct MovieRender: Identifiable  { // hashable gives random id
    var id = UUID() // automatically trackable
    var title: String
    var sexy: Bool
    var ratings: [Int]  //array!!
}
    
    //   class, viewmodel, datamodel -> need init()

    // double for stars UI
    func repeatinZeroFromRatng(rating: Double) -> [Int] {
        // write logic to solve our problem
        var starTiersArray = [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
        var smallestDifference: Double = 0
  
        // NOW:
        // 4.5 -> [0.0.0.0] -> 4 stars Images
        
        // [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
        // abs() - gets the absolute value of a number (-0.3 -> 0.3, 0.3 -> 0.3)
        
        for (index, item) in starTiersArray.enumerated() {
            var differenceCurr = abs(item - rating) //here we make the result absolute
            
            //1-4 =  - 3
            //1-1.5 = - 0.5
           
            if index == 0 {
                 smallestDifference = differenceCurr
            } else {
                print("The differnce is not smaller than rating")
            }
        }
        
        for (index, item) in starTiersArray.enumerated() {
            if (item == 0) {
                difference = Int(item)
            } else {
                // check if smaller we update
                
            }
        }

        
        // algorythm -> convert little bit of t he closest
        // 4.5 -> [?.?.?.?.?] -> 4 stars and 1 Half Star
        return Array.init(repeating: 0, count: Int(floor(rating))) //floor will round down to the next closest whole number
    }
    

    
    
    var body: some View {
        VStack {
            
            //  Show Ratings Practices
            Text("Ratng Practices")

            
            ForEach(movieList) { movie in
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
                Text(movie.title)
                
                HStack{
                    // [0,0,0]
                    ForEach(movie.ratings, id: \.self) { number in
                        Image(systemName: "star.fill")
                    }
                }
            }
            
        }
        .onAppear {
            print("movieData: \(movieData)")
            
            // set up movie list
            let formattedMovieList = movieData.map { movie in
                //eaach movie 1 by 1
                
                MovieRender(
                    title: movie.title, sexy: movie.sexy,
                    ratings: repeatinZeroFromRatng(rating: movie.ratings))
            }
            
            self.movieList = formattedMovieList
        }
        
    }
    
}


#Preview {
    MovieList()
}
