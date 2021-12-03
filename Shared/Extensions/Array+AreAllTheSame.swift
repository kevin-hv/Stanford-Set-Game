//
//  Array+AreAllTheSame.swift
//  Stanford-Set-Game
//
//  Created by Kevin Varga on 30/12/2020.
//

import Foundation

extension Collection where Element : Equatable {
    func areAllTheSame() -> Bool {
        guard let firstElement = self.first else { return false }
        
        return self.allSatisfy{ $0 == firstElement }
    }
}
