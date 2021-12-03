//
//  GridView.swift
//  Stanford2020-01-Recreation-02
//
//  Created by Kevin Varga on 23/12/2020.
//

import SwiftUI

struct GridView<Element : Identifiable, ElementView : View>: View {
    
    private var elements : [Element]
    
    private var viewFacotry : (Element) -> (ElementView)
    
    init(_ elements : [Element], factory: @escaping (Element) -> (ElementView) ){
        self.elements = elements
        self.viewFacotry = factory
    }
    
    var body: some View {
        GeometryReader{ geometry in
            let layout = GridLayout(itemCount: elements.count, in: geometry.size)
            ForEach(Array(elements.enumerated()), id: \.element.id){ index, element in
                viewFacotry(element)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
            
        }
    }
}
