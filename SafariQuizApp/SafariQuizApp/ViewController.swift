//
//  ViewController.swift
//  SafariQuizApp
//
//  Created by Алеся Афанасенкова on 20.02.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    let questions: [QuestionModel] = [
        QuestionModel(image: UIImage(named: "lion")!, correctAnswer: 2, answer1: "Hippo", answer2: "Lion", answer3: "Antelope"),
        QuestionModel(image: UIImage(named: "giraffe")!, correctAnswer: 1, answer1: "Giraffe", answer2: "Crocodile", answer3: "Elephant"),
        QuestionModel(image: UIImage(named: "buffalo")!, correctAnswer: 3, answer1: "Hippo", answer2: "Elephant", answer3: "Buffalo")]
    var score: Int = 0
    var currentQuestionIndex = 0
    var sizeClass: (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
        return (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass)
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestion()
        style()
    }
    
    func style() {
        switch sizeClass {
            // Iphone landscape (small and big)
        case (.compact, .compact), (.regular, .compact):
            scoreLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            // Iphone portrait
        case (.compact, .regular) :
            scoreLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        case (.regular, .regular) :
            scoreLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
            default:
            scoreLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)        }
        [answer1Button, answer2Button, answer3Button].forEach { button in
            switch sizeClass {
                // Iphone landscape (small and big)
            case (.compact, .compact), (.regular, .compact):
                button?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
                // Iphone portrait
            case (.compact, .regular) :
                button?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            case (.regular, .regular) :
                button?.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
                default:
                button?.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            }
            button?.layer.cornerRadius = 6
           
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        guard currentQuestionIndex <= questions.count - 1 else {
            currentQuestionIndex = 0
            score = 0
            scoreLabel.text = "Score 0"
            setupQuestion()
            return
        }
        setupQuestion()
    }
    
    func setupQuestion() {
        
        let currentQuestion = questions[currentQuestionIndex]
        questionImageView.image = currentQuestion.image
        answer1Button.setTitle(currentQuestion.answer1, for: .normal)
        answer2Button.setTitle(currentQuestion.answer2, for: .normal)
        answer3Button.setTitle(currentQuestion.answer3, for: .normal)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.nextQuestion()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
//    func showFinalScoreAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
//            self.nextQuestion()
//        }
//        alert.addAction(okAction)
//        present(alert, animated: true)
//    }
    
    func check(selectedAnswer answer: Int) {
        let currenQuestion = questions[currentQuestionIndex]
        var alertTitle = ""
        var alertMessage = ""
        if currenQuestion.correctAnswer == answer {
            print("Answer is correct!")
            score += 1
            scoreLabel.text = "Score \(score)"
                alertTitle = "Correct!"
                alertMessage = "You got the correct answer!"
            
        } else {
            print("Answer is incorrect")
                alertTitle = "Incorrect!"
                alertMessage = "You got the wrong answer!"
           
        }
        if currentQuestionIndex == questions.count - 1 {
            alertTitle = "End of Quiz"
            alertMessage = "Your final score is \(score) / \(questions.count)"
        }
        showAlert(title: alertTitle, message: alertMessage)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        check(selectedAnswer: sender.tag)
    }
    
}

