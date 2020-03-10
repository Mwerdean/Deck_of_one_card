//
//  CardViewController.swift
//  Deck_of_one_card
//
//  Created by Matthew Werdean on 3/10/20.
//  Copyright © 2020 Matthew Werdean. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
        // MARK: - Actions
    @IBAction func buttonTapped(_ sender: Any) {
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let card):
                    self?.fetchImageAndUpdateView(with: card)
                    
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    // MARK: - Methods
    func fetchImageAndUpdateView(with card: Card) {
        
        CardController.fetchImage(for: card) { [weak self] (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let image):
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                    self?.cardImageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
