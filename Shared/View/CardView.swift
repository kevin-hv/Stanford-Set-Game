//
//  CardView.swift
//  Stanford-Set-Game (iOS)
//
//  Created by Kevin Varga on 31/12/2020.
//

import SwiftUI

struct CardView: View {
    
    let card : SetGameModel.Card
    
    var body: some View {
        cardFaceFor(card: card)
            .cardify(isFaceUp: true, isSelected: card.isChosen)
            .foregroundColor(card.isInSet ? .orange : card.color.actualColor)
            .aspectRatio(2/3, contentMode: .fit)
    }
    
    private func cardFaceFor(card: SetGameModel.Card) -> some View {
        VStack{
            ForEach(Array((0..<card.number.rawValue)), id: \.self){ _ in
                cardSymbol(for: card)
            }
        }
    }
    
    @ViewBuilder
    private func cardSymbol(for card: SetGameModel.Card) -> some View {
        ZStack{
            let lineWidth : CGFloat = 3
            
            switch card.shape {
            case .capsule:
                switch card.shading {
                case .empty:
                    Capsule()
                        .stroke(lineWidth: lineWidth)
                case .filled:
                    Capsule()
                        .fill()
                case .striped:
                    Capsule()
                        .striped()
                }
            case .diamond:
                switch card.shading {
                case .empty:
                    Diamond()
                        .stroke(lineWidth: lineWidth)
                case .filled:
                    Diamond()
                        .fill()
                case .striped:
                    Diamond()
                        .striped()
                }
            case .flag:
                switch card.shading {
                case .empty:
                    Flag()
                        .stroke(lineWidth: lineWidth)
                case .filled:
                    Flag()
                        .fill()
                case .striped:
                    Flag()
                        .striped()
                }
            }
        }
        .aspectRatio(3/2, contentMode: .fit)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(number: .one, shape: .flag, shading: .striped, color: .green))
    }
}
