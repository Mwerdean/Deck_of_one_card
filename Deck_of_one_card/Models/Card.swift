//
//  Card.swift
//  Deck_of_one_card
//
//  Created by Matthew Werdean on 3/10/20.
//  Copyright © 2020 Matthew Werdean. All rights reserved.
//

import Foundation

struct Card: Codable {
    let value: String
    let suit: String
    let image: URL
}


struct CardObject: Codable {
     let cards: [Card]
}
