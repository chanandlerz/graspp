//
//  HightlightString.swift
//  graspp
//
//  Created by Nadia Putri Natali Lubis on 19/06/26.
//

import Foundation
import SwiftUI

extension String {
    func highlighted(query: String, color: Color = .yellow, baseColor: Color = .primary) -> Text {
        guard !query.isEmpty else {
            return Text(self).foregroundStyle(baseColor)
        }
        
        var attributed = AttributedString(self)
        var searchRange = attributed.startIndex..<attributed.endIndex

        // Set base color dulu ke seluruh string
        attributed.foregroundColor = UIColor(baseColor)

        while let range = attributed[searchRange].range(of: query, options: .caseInsensitive) {
            attributed[range].font = .body.bold()
            attributed[range].foregroundColor = UIColor(color)
            searchRange = range.upperBound..<attributed.endIndex
        }
        
        return Text(attributed)
    }
}
