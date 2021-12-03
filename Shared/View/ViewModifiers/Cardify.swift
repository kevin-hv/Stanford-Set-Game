//
//  Cardify.swift
//  Stanford-Set-Game
//
//  Created by Kevin Varga on 29/12/2020.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation : Double
    
    var flagOpacity : Double
    
    var isFaceUp : Bool {
        rotation < 0.5
    }
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(rotation, flagOpacity) }
        set {
            rotation = newValue.first
            flagOpacity = newValue.second
        }
    }
    
    init(isFaceUp: Bool, isSelected: Bool){
        rotation = isFaceUp ? 0 : 1
        flagOpacity = isSelected ? 1 : 0
    }
    
    func body(content: Content) -> some View {
        GeometryReader{ globalProxy in
            ZStack{
                RoundedRectangle(cornerRadius: cardRoundness(for: globalProxy.size))
                ZStack{
                    RoundedRectangle(cornerRadius: cardRoundness(for: globalProxy.size))
                        .fill(Color.white)
                        .overlay(
                            GeometryReader{ faceProxy in
                                HStack{
                                    Spacer()
                                    Circle()
                                        .frame(width: flagSize(for: faceProxy.size), height: flagSize(for: faceProxy.size))
                                        .rotationEffect(.degrees(45))
                                        .padding(flagPadding(for: faceProxy.size))
                                        .opacity(flagOpacity)
                                }
                            
                            }, alignment: .topTrailing)
                        .overlay(
                            GeometryReader{ faceProxy in
                                content
                                    .padding()
                                    .frame(width: faceProxy.size.width, height: faceProxy.size.height)
                        })
                        .padding(cardFacePadding(for: globalProxy.size))
                }
                .opacity(isFaceUp ? 1 : 0)
            }
            .rotation3DEffect(
                Angle(degrees: rotation * 180),
                axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        }
        
    }
    
    private func flagSize(for size : CGSize) -> CGFloat {
        return max(minimumFlagSize, min(size.height, size.width) / 18)
    }
    
    private func flagPadding(for size: CGSize) -> CGFloat {
        return flagSize(for: size)
    }
    
    private func cardRoundness(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) / 9
    }
    
    private func cardFacePadding(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) / 30
    }
    
    private let minimumFlagSize : CGFloat = 4
}

struct Cardify_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            Text("Hi")
                .cardify(isFaceUp: true)
                .aspectRatio(2/3, contentMode: .fit)
                .foregroundColor(.blue)
            Text("Hi")
                .cardify(isFaceUp: true, isSelected: true)
                .aspectRatio(2/3, contentMode: .fit)
                .foregroundColor(.green)
            Text("Hi")
                .cardify(isFaceUp: false)
                .aspectRatio(2/3, contentMode: .fit)
                .foregroundColor(.red)
        }
        
    }
}

extension View {
    func cardify(isFaceUp : Bool = true, isSelected : Bool = false) -> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp, isSelected: isSelected))
    }
}
