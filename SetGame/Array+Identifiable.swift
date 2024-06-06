//
//  Array+Identifiable.swift
//  SetGame
//
//  Created by Emme Anais Dawes on 2023-10-19.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching targetElement: Element) -> Int? {
        for index in self.indices {
            if self[index].id == targetElement.id {
                return index
            }
        }
        
        return nil
    }
}
