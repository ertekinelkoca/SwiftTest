//
//  ViewController.swift
//  CatchTheObjectGame
//
//  Created by mac on 25.09.2020.
//  Copyright © 2020 AEE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var highScore = 0
    var objcArray = [UIImageView]()

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    @IBOutlet weak var im1: UIImageView!
    @IBOutlet weak var im2: UIImageView!
    @IBOutlet weak var im3: UIImageView!
    @IBOutlet weak var im4: UIImageView!
    @IBOutlet weak var im5: UIImageView!
    @IBOutlet weak var im6: UIImageView!
    @IBOutlet weak var im7: UIImageView!
    @IBOutlet weak var im8: UIImageView!
    @IBOutlet weak var im9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("add to git check line")
        scoreLabel.text = "Score : \(score)"
        
        //highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            
            highScore = 0
            highScoreLabel.text =  "Highscore = : \(highScore)"
        
        }
        
        if let newScore = storedHighScore as? Int {
            
            highScore = newScore
            highScoreLabel.text = "Highscore : \(highScore)"
        
        }
    
        im1.isUserInteractionEnabled = true
        im2.isUserInteractionEnabled = true
        im3.isUserInteractionEnabled = true
        im4.isUserInteractionEnabled = true
        im5.isUserInteractionEnabled = true
        im6.isUserInteractionEnabled = true
        im7.isUserInteractionEnabled = true
        im8.isUserInteractionEnabled = true
        im9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        im1.addGestureRecognizer(recognizer1)
        im2.addGestureRecognizer(recognizer2)
        im3.addGestureRecognizer(recognizer3)
        im4.addGestureRecognizer(recognizer4)
        im5.addGestureRecognizer(recognizer5)
        im6.addGestureRecognizer(recognizer6)
        im7.addGestureRecognizer(recognizer7)
        im8.addGestureRecognizer(recognizer8)
        im9.addGestureRecognizer(recognizer9)
        
        objcArray = [im1,im2,im3,im4,im5,im6,im7,im8,im9]
        
        //timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideObject), userInfo: nil, repeats: true)
        
        hideObject()
            
    }
    
    @objc func hideObject(){
        
        for objc in objcArray{
            objc.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(objcArray.count-1)))
        objcArray[random].isHidden = false
        
        
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
     
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            
            //high Score
            if self.score > self.highScore{
                self.highScore = score
                highScoreLabel.text = "High Score : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "high score")
                
            }
            
            
            for objc in objcArray{
                       objc.isHidden = true
                   }
            
            let alert = UIAlertController(title: "time is up", message: "do you want to play again", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideObject), userInfo: nil, repeats: true)

            }
                            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
    
        }
    }
    
    @objc func increaseScore(){
        
        score = score + 1
        scoreLabel.text = "Score : \(score)"
        
    }

}

