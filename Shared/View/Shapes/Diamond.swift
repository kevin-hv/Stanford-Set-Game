//
//  Diamond.swift
//  Stanford-Set-Game
//
//  Created by Kevin Varga on 29/12/2020.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path : Path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        
        return path
    }
    
   
}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
            .foregroundColor(.red)
    }
}


