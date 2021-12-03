//
//  SetGame.swift
//  Stanford-Set-Game
//
//  Created by Kevin Varga on 29/12/2020.
//

import SwiftUI

struct SetGameModel {
    
    static var fullDeck : [Card] = {
        var cards : [Card] = []
        
        Card.Color.allCases.forEach { color in
            Card.Shading.allCases.forEach { shading in
                Card.Shape.allCases.forEach { shape in
                    Card.Number.allCases.forEach {number in
                        cards.append(Card(number: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        
        return cards
    }()
    
    private var cards : [Card] = SetGameModel.fullDeck.shuffled()
    
    private var notDealtCardIndicess : [Int] {
        cards.indices.filter({cards[$0].isDealt == false})
    }
    
    var dealtCards : [Card] {
        cards.filter({$0.isDealt})
    }
    
    var cardsOnTable : [Card] {
        cards.filter({$0.isDealt && !$0.isInSet})
    }
    
    var notInSetCards : [Card] {
        cards.filter({$0.isInSet == false})
    }
    
    var inSetCards : [Card] {
        cards.filter({$0.isInSet})
    }
    
    var chosenCards : [Card] {
        cards.filter({$0.isChosen})
    }
    
    var amountOfOverallCards : Int {
        cards.count
    }
    
    var isGameOver : Bool = false
    
    private var chosenCardIndices : [Int] {
        return cards.indices.filter({ i in chosenCards.contains(where: {cards[i].id == $0.id})})
    }
    
    private var areChosenCardsFormingASet : Bool {
        return chosenCards.count == 3 && chosenCards.reduce(true, { result, card in
            result && card.formsASetWith(cards: chosenCards.filter({$0.id != card.id}))
        })
    }
    
    private mutating func refreshGameOverState(){
        
        guard notDealtCardIndicess.count == 0 else {
            isGameOver = false
            return
        }
        
        isGameOver = !isContainingSet(in: notInSetCards)
    }
    
    private func isContainingSet(in cards: [Card]) -> Bool {
        for card in cards {
            for secondCard in cards.filter({$0.id != card.id}){
                for thirdCard in cards.filter({$0.id != card.id && $0.id != secondCard.id}){
                    if (card.formsASetWith(cards: [secondCard, thirdCard])){
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    mutating func choose(card: Card) {
        guard let indexOfChosenCard = cards.firstIndex(where: {$0.id == card.id}), card.isDealt && card.isInSet == false else { return }
        
        cards[indexOfChosenCard].isChosen.toggle()
        
        if chosenCards.count > 3 {
            chosenCardIndices.filter({$0 != indexOfChosenCard}).forEach{ cards[$0].isChosen = false }
        }
        
        if areChosenCardsFormingASet {
            chosenCardIndices.forEach{ cards[$0].isInSet = true }
            dealCards()
            refreshGameOverState()
        }
        
    }
    
    mutating func dealCards(){
        while((notDealtCardIndicess.count > 0 && cardsOnTable.count < 12) || (notDealtCardIndicess.count > 0 && isContainingSet(in: cardsOnTable) == false)){
            notDealtCardIndicess.prefix(3).forEach{cards[$0].isDealt = true}
        }
    }
    
    struct Card : Identifiable, Codable {
        
        var id: String {
            "\(shape.rawValue), \(shading.rawValue), \(color.rawValue), \(number.rawValue)"
        }
        
        enum Shape : String, CaseIterable, Codable {
            case diamond, capsule, flag
        }
        
        enum Shading : String, CaseIterable, Codable {
            case empty, striped, filled
        }
        
        enum Color : String, CaseIterable, Codable {
            case green, pink, blue
            
            var actualColor : SwiftUI.Color {
                switch self {
                case .green:
                    return .green
                case .pink:
                    return .pink
                case .blue:
                    return .blue
                }
            }
        }
        
        enum Number : Int, CaseIterable, Codable {
            case one = 1, two, three
        }
        
        let number : Number
        
        let shape : Shape
        
        let shading: Shading
        
        let color : Color
        
        var isDealt : Bool = false
        
        var isInSet : Bool = false
        
        var isChosen : Bool = false
        
        func formsASetWith(cards : [Card]) -> Bool {
            
            guard cards.contains(where: {$0.id == id}) == false else { return false }
            
            let cardsWithSelf = cards + [self]
            
            let sameShapeCount = Dictionary(uniqueKeysWithValues: Shape.allCases.map { shape in (shape, cardsWithSelf.filter({$0.shape == shape}).count) })
            
            guard (sameShapeCount.values.contains(3) || sameShapeCount.values.areAllTheSame()) else { return false }
            
            let sameShapeShading = Dictionary(uniqueKeysWithValues: Shading.allCases.map { shading in (shading, cardsWithSelf.filter({$0.shading == shading}).count) })
            
            guard (sameShapeShading.values.contains(3) || sameShapeShading.values.areAllTheSame()) else { return false }
            
            let sameShapeColor = Dictionary(uniqueKeysWithValues: Color.allCases.map { color in (color, cardsWithSelf.filter({$0.color == color}).count) })
            
            guard (sameShapeColor.values.contains(3) || sameShapeColor.values.areAllTheSame()) else { return false }
            
            let sameShapeNumber = Dictionary(uniqueKeysWithValues: Number.allCases.map { number in (number, cardsWithSelf.filter({$0.number == number}).count) })
            
            guard (sameShapeNumber.values.contains(3) || sameShapeNumber.values.areAllTheSame()) else { return false }
            
            return true
        }
    }
}


