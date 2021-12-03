//
//  SetGameViewModel.swift
//  Stanford-Set-Game
//
//  Created by Kevin Varga on 29/12/2020.
//

import Foundation

class SetGameViewModel : ObservableObject {
    @Published private var setGameModel = SetGameModel()
    
    init(){
        
    }
    
    var completeness : Double {
        Double(amountOfCardsInSet) / Double(amountOfOverallCards)
    }
    
    var amountOfOverallCards : Int {
        setGameModel.amountOfOverallCards
    }
    
    var amountOfCardsInSet : Int {
        setGameModel.inSetCards.count
    }
    
    func resetGame(){
        setGameModel = SetGameModel()
    }
    
    var isGameOver : Bool {
        setGameModel.isGameOver
    }
    
    func choose(card: SetGameModel.Card){
        setGameModel.choose(card: card)
    }
    
    func dealTable() {
        setGameModel.dealCards()
    }
    
    func dealCards() {
        setGameModel.dealCards()
    }
    
    var cardsOnTable : [SetGameModel.Card] {
        setGameModel.cardsOnTable
    }
    
    var cardsChosen : [SetGameModel.Card] {
        setGameModel.chosenCards
    }
}
