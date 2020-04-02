//
//  Rating.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 01.04.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

class UserRating : ObservableObject {
    @Published var rating = 4
    init(rating: Int) {
        self.rating = rating
    }
}

struct Rating: View {
    @EnvironmentObject var userRating : UserRating
    
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.userRating.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.userRating.rating = number
                        print("Tap gesture!")
                }
            }
        }     
    }
    
    func image(for number: Int) -> Image {
        if number > userRating.rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating()
    }
}
