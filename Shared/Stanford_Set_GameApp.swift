//
//  Stanford_Set_GameApp.swift
//  Shared
//
//  Created by Kevin Varga on 29/12/2020.
//

import SwiftUI

@main
struct Stanford_Set_GameApp: App {
    var setGameViewModel : SetGameViewModel = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(setGameViewModel: setGameViewModel)
        }
    }
}
