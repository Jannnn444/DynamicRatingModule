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

// for UI
struct MovieRender: Identifiable  { // hashable gives random id
    var id = UUID() // automatically trackable
    var title: String
    var sexy: Bool
    var ratings: [Int]  //array!!
} //   class, viewmodel, datamodel -> need init()
    
    // double for stars UI
    func repeatinZeroFromRatng(rating: Double) -> [Int] {
        // write logic to solve our problem
        var starTiersArray = [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]
        var cloestTier: Double = 0.0
        var smallestDifference: Double = 6.0
        var starArray:[Int] = []
        
        // NOW:
        // 4.5 -> [0.0.0.0] -> 4 stars Images
        
        // abs() - gets the absolute value of a number (-0.3 -> 0.3, 0.3 -> 0.3)
        
        for item in starTiersArray {  
            // [1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5]
            
            // rating = 2
            // diff = [1, 0.5, 0, 0.5, 1, 1.5, 2, 2.5]
            
            let diff = abs(item - rating)  // this abs() will no minus
            
            if diff < smallestDifference {
                smallestDifference = diff // give the destination updated value
                cloestTier = item 
                // ！Update the cloest tier when a small difference is found ！
            }
        }
        // algorythm
        // 4.5 -> [0, 0, 0, 0, 1] -> 4 stars and 1 Half Star
        
        // Divided our cloestTier Int
        let intergerPart = Int(floor(cloestTier)) // 4 from 4.5
        let fractionalPart = cloestTier - Double(intergerPart) // 0.5 from 4.5
        
        starArray = Array(repeating: 0, count: intergerPart)
        
        if fractionalPart > 0 {
            starArray.append(1)
        }
        
        print("star array : \(starArray)")
        return starArray
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
