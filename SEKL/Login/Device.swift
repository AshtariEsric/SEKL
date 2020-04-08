//
//  Device.swift
//  
//
//  Created by Dennis Hasselbusch on 08.04.20.
//

import Combine
import UIKit

class Device : ObservableObject {
    @Published var isLandscape : Bool = false
    
    public init(){}
}
