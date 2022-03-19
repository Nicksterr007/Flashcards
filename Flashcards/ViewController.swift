//
//  ViewController.swift
//  Flashcards
//
//  Created by Nichola Csmpbell on 3/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTaponFlashcard(_ sender: Any) {
        
        
       if frontLabel.isHidden == true {
            frontLabel.isHidden = false

        }
        else {
            frontLabel.isHidden = true
        }

    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

