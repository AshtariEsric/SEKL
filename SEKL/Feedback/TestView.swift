//
//  TestView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 08.04.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            MyRectangle()
        }.frame(width: 150, height: 100).border(Color.black)
    }
}

struct MyRectangle : View {
    var body : some View {
        Rectangle()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
