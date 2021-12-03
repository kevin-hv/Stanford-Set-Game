//
//  Flag.swift
//  Stanford-Set-Game
//
//  Created by Kevin Varga on 29/12/2020.
//

import SwiftUI

struct Flag: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let padding : CGFloat = rect.midY/2
        let minX: CGFloat = rect.minX
        let maxX: CGFloat = rect.maxX
        let minY: CGFloat = rect.minY + padding
        let maxY: CGFloat = rect.maxY - padding
        path.move(to: CGPoint(x: minX, y: minY))
        path.addCurve(to: CGPoint(x: rect.midX, y: minY), control1: CGPoint(x: rect.minX, y: minY - padding), control2: CGPoint(x: rect.midX, y: minY - padding))
        path.addCurve(to: CGPoint(x: maxX, y: minY), control1: CGPoint(x: rect.midX, y: minY + padding), control2: CGPoint(x: maxX, y: minY + padding))
        path.addCurve(to: CGPoint(x: maxX, y: maxY), control1: CGPoint(x: maxX, y: minY + padding), control2: CGPoint(x: maxX, y: maxY))
        path.addCurve(to: CGPoint(x: rect.midX, y: maxY), control1: CGPoint(x: maxX, y: maxY + padding), control2: CGPoint(x: rect.midX, y: maxY + padding))
        path.addCurve(to: CGPoint(x: minX, y: maxY), control1: CGPoint(x: rect.midX, y: maxY - padding), control2: CGPoint(x: minX, y: maxY - padding))
        
        path.closeSubpath()
        return path
    }
    
    
}

struct Flag_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Flag()
                .fill(Color.blue)
            
         
        }
        
    }
}
