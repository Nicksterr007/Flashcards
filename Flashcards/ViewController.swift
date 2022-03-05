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
        
        frontLabel.isHidden = true
    }

}

