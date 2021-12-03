//
//  ContentView.swift
//  Shared
//
//  Created by Kevin Varga on 29/12/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var setGameViewModel : SetGameViewModel
    
    var body: some View {
        VStack{
            if setGameViewModel.isGameOver {
                VStack{
                    Text("Victory!")
                    
                    Text("\(setGameViewModel.amountOfCardsInSet)/\(setGameViewModel.amountOfOverallCards)")
                        .padding()
                    
                    Button{
                        withAnimation{
                            setGameViewModel.resetGame()
                        }
                    } label: {
                        Text("New Game")
                            .padding()
                    }
                }
                .padding()
                
            } else {
                VStack{
                    
                    ProgressView(value: setGameViewModel.completeness)
                        .padding([.leading, .trailing])
                    
                    GridView(setGameViewModel.cardsOnTable){
                        card in
                        GeometryReader{ proxy in
                            CardView(card: card)
                            .onTapGesture{
                                withAnimation(.easeInOut) {
                                    setGameViewModel.choose(card: card)
                                }
                            }
                            .padding()
                            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                        }
                        .transition(.move(edge: [.top, .bottom, .trailing, .leading].randomElement()!))
                            
                        
                    }.onAppear{
                        if setGameViewModel.cardsOnTable.count == 0 {
                            withAnimation(.easeInOut){
                                setGameViewModel.dealTable()
                            }
                            
                        }
                    }
                }
                .padding([.top])
                
                
            }
            
        }
        
    }
    
    private func startingXOffset(forFrameOfCardDealt frameOfCardDealt : CGRect) -> CGFloat {
        let startingXOffset = Bool.random() ? frameOfCardDealt.minX - frameOfCardDealt.size.width : frameOfCardDealt.maxX + frameOfCardDealt.size.width
        return startingXOffset
    }
    
    private func startingYOffset(forFrameOfCardDealt frameOfCardDealt : CGRect) -> CGFloat {
        let startingYOffset = Bool.random() ? frameOfCardDealt.minY - frameOfCardDealt.size.height : frameOfCardDealt.maxY + frameOfCardDealt.size.height
        return startingYOffset
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(setGameViewModel: SetGameViewModel())
    }
}
