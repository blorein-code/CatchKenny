//
//  ViewController.swift
//  CatchKenny
//
//  Created by Berke Topcu on 15.10.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    var timer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    var kennies = [UIImageView]()
    var pictureTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeWillChange), userInfo: nil, repeats: true)
        pictureTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(hideImages), userInfo: nil, repeats: true)
        var savedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if savedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        if let newScore = savedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        scoreLabel.text! = "Score: \(score)"
        highScoreLabel.text! = "High Score: \(savedHighScore!)"
        
        
        kennies = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        hideImages()
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(kennyTiklandi))
        //kullanıcının tıklama bilgisini almayı aktifleştirdik.
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        // tıklanınca çalışacak fonksiyonu kennylere dahil ettik
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        
    }


    @objc func timeWillChange() {
        counter -= 1
        timerLabel.text = "Time: \(counter)"
        
        
        if counter == 0 {
            timer.invalidate()
            pictureTimer.invalidate()
            
            if self.score > self.highScore {
                highScoreLabel.text = "High Score: \(self.score)"
                let saveScore = UserDefaults.standard.set(score, forKey: "highscore")
            }
            
            for kenny in kennies {
                kenny.isHidden = true
            }
           
            
            
            let alert = UIAlertController(title: "Over", message: "Time is over", preferredStyle: UIAlertController.Style.alert)
            let cancelBtn = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
            let restartBtn = UIAlertAction(title: "Restart", style: UIAlertAction.Style.cancel) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timerLabel.text = "Time: \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeWillChange), userInfo: nil, repeats: true)
                self.pictureTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(self.hideImages), userInfo: nil, repeats: true)
                
               
                
            }
            alert.addAction(restartBtn)
            alert.addAction(cancelBtn)
            self.present(alert, animated: true, completion: nil)
        }
        
        
      
    }
    
   
    
    @objc func kennyTiklandi() {
        score += 1
        scoreLabel.text = String("Score: \(score)")
    }
    
    @objc func hideImages() {
        for kenny in kennies {
            kenny.isHidden = true
        }
    let random = Int(    arc4random_uniform(UInt32(kennies.count - 1)))
        kennies[random].isHidden = false
    }
    
}

