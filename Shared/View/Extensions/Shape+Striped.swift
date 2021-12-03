//
//  Shape+Striped.swift
//  Stanford-Set-Game (iOS)
//
//  Created by Kevin Varga on 30/12/2020.
//

import SwiftUI

extension Shape {
    func striped(secondaryColor: Color = .clear, amountOfStripes: Int = 5) -> some View {
        
        return
            ZStack{
                if amountOfStripes > 2 {
                    HStack(spacing: 0){
                        Rectangle()
                        Rectangle()
                            .fill(secondaryColor)
                        
                        ForEach(0..<amountOfStripes - 2){ i in
                            Rectangle()
                            Rectangle()
                                .fill(secondaryColor)
                        }

                        Rectangle()
                    }
                } else {
                    HStack(spacing: 0){
                        ForEach(0..<amountOfStripes){ i in
                            Rectangle()
                            Rectangle()
                                .fill(secondaryColor)
                        }
                    }
                }
            }
            .mask(self)
        
    }
}

struct Shape_Striped_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Circle()
                .striped(amountOfStripes: 5)
                .aspectRatio(1, contentMode: .fit)
            Rectangle()
                .striped()
                .aspectRatio(1, contentMode: .fit)
            Diamond()
                .striped()
                .aspectRatio(1, contentMode: .fit)
            Flag()
                .striped()
                .aspectRatio(1, contentMode: .fit)
        }
        .padding()
        
    }
}
