//
//  ViewController.swift
//  Flashcard
//
//  Created by Madina Monowara on 9/13/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    //dkjheiuhg       

    //comment
    func updateFlashcard(question: String, answer: String){
        frontLabel.text = question
        backLabel.text = answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //We know the destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        //We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        // We set the flashcardsController property to self
        creationController.flashcardsController = self
    }
    
    
}

