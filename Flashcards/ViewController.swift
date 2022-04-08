//
//  ViewController.swift
//  Flashcards
//
//  Created by Nichola Csmpbell on 3/4/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "How are you doing?", answer: "Great!")
        } else {
            updateLabels()
        }
        updateNextPrevButtons()
    }
    
    @IBAction func didTaponFlashcard(_ sender: Any) {
        
      flipFlashcard()

    }
    
    func flipFlashcard() {
        
        if frontLabel.isHidden == true {
             frontLabel.isHidden = false

         }
         else {
             frontLabel.isHidden = true
         }
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight) {
            //self.frontLabel.isHidden = true
        }

    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        flashcards.append(flashcard)
        
        print("Added a new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOut1()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        currentIndex = currentIndex + 1
        
        updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOut()
        
    }
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    
    
    @IBOutlet weak var card: UIView!
    
    @IBAction func prevButton(_ sender: Any) {
    }
    
    func updateNextPrevButtons() {
        
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }else {
            prevButton.isEnabled = true }
        
        }
    
    func updateLabels() {
        
        let currentFlashcard = flashcards[currentIndex]
        
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")

        
    }
    
    func readSavedFlashcards() {
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        } completion: { finished in
            
            self.updateLabels()
            
            self.animateCardIn()
        }

    }

    func animateCardIn() {
        
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOut1() {
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        } completion: { finished in
            
            self.updateLabels()
            
            self.animateCardIn1()
        }

    }

    func animateCardIn1() {
        
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
}



