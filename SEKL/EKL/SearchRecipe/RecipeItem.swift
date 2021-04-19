//
//  RecipeItem.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 19.04.21.
//  Copyright © 2021 Dennis Hasselbusch. All rights reserved.
//

import Foundation
import CoreData

struct RecipeItem: Identifiable, Codable {
    var id = UUID()
    var beschreibung : String = ""
    var zutaten : Array<Zutat>
}

class Recipe : ObservableObject {
    @Published var items = [RecipeItem]()
        {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try?
                encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let ReItems = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            
            if let decoded = try?
                decoder.decode([RecipeItem].self, from: ReItems){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
