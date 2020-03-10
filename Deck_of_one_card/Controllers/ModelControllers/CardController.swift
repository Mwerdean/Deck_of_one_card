//
//  CardController.swift
//  Deck_of_one_card
//
//  Created by Matthew Werdean on 3/10/20.
//  Copyright © 2020 Matthew Werdean. All rights reserved.
//

import UIKit

class CardController {
    
    static private let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                print("Error", error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let topLevel = try JSONDecoder().decode(CardObject.self, from: data)
                guard let card = topLevel.cards.first else { return completion(.failure(.noData))}
                return completion(.success(card))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
        // @escaping means the closure can run after the function returns. Perfect for concurrency/multi-threading.
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        
        let url = card.image
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                return completion(.failure(.thrown(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(image))
            
        }.resume()
    }
}
