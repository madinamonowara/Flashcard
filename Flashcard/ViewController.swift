//
//  ViewController.swift
//  Flashcard
//
//  Created by Madina Monowara on 9/13/22.
//

import UIKit
struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    var flashcards  = [Flashcard]()
    var currentindex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readSavedFlashcards()
        // Do any additional setup after loading the view.
        if flashcards.count == 0{
            updateFlashcard(question: "What is the capital of Brazil?", answer: "Brasilia")
        } else{
            updateLabels()
            updateNextPrevButtons()
        }
    }
    //comment
    
    @IBOutlet weak var card: UIView!
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    //lab 0ct 25 week 7
    func flipFlashcard(){
        if frontLabel.isHidden == true {
            frontLabel.isHidden = false
        } else{
            frontLabel.isHidden = true
        }
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {self.frontLabel.isHidden = true})
    }
    
    func animateCardout(){
        UIView.animate(withDuration: 0.3, animations:
                {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.00, y: 0.0)
        }, completion: {finished in
            self.updateLabels()
            self.animateCardin()
        })
    }
    func animateCardin(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.00, y: 0.0)
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    //@IBAction func didTapOnPrev(_ sender: Any) {
       // currentindex = currentindex - 1
      //  updateNextPrevButtons()
      //  updateLabels()
        
    //}
    
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentindex = currentindex - 1
        updateNextPrevButtons()
        updateLabels()
        animateCardout()
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentindex = currentindex + 1
        updateNextPrevButtons()
        updateLabels()
        animateCardout()
    }
    
    //@IBAction func didTapOnNext(_ sender: Any) {
        //currentindex = currentindex + 1
        //updateNextPrevButtons()
       // updateLabels()
      //  animateCardout()
   // }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentindex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    //comment
    func updateFlashcard(question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        //frontLabel.text = question
        //backLabel.text = answer
        
        //add flashcard to array
        flashcards.append(flashcard)
        
        //print("Added a new flashcard, take a look ->", flashcards)
        
        //logging to the console
        print("Added a new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        // update curent index
        currentindex = flashcards.count - 1
        print("Our new index is \(currentindex)")
        
        //update next & prev buttons
        updateNextPrevButtons()
        //update labels after current index is updated
        updateLabels()
        //save to disk
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        //disable next button if at the end
        if currentindex == flashcards.count - 1{
            nextButton.isEnabled = false
        } else{
            nextButton.isEnabled = true
        }
        // disable prev button at beginning
        if currentindex == 0 {
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
        
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map{ (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)}
                
                flashcards.append(contentsOf:savedCards)
            }
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

