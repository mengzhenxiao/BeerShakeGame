//
//  GameViewController.swift
//  IOSShakeGestureTutorial
//
//  Created by Roxanne Kim on 3/13/19.
//  Copyright © 2019 Arthur Knopper. All rights reserved.
//

import UIKit

protocol MotionDelegate {
    func motionBegan(motion: UIEvent.EventSubtype, withEvent event: UIEvent?)
    func motionCancelled(motion: UIEvent.EventSubtype, withEvent event: UIEvent?)
    func motionEnded(motion: UIEvent.EventSubtype, withEvent event: UIEvent?)
}


class GameViewController: UIViewController {
    @IBOutlet weak var shakeLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameView: UIView!
    
    
    var scores: [Int] = []
    var shakeCounter = 0
    var greatestScore = 0
    
    var startInt = 3
    var startTimer = Timer()
    
    var gameInt = 10
    var gameTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameView.isHidden = true
        
        startInt = 3
        //shakeLabel.text = String(startInt)
        
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        
        gameInt = 10
        timeLabel.text = String(gameInt)
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        self.shakeLabel.isHidden = false
        
        if motion == .motionShake {
            
            self.shakeLabel.isHidden = true
            self.gameView.isHidden = false
            
            shakeCounter += 1
            scoreLabel.text = "\(shakeCounter)"
            scores.append(shakeCounter)
            print(scores)
            
            let greatestScore = scores.max()
            print(greatestScore ?? 0)
            
           
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        
        
    }
    
    @objc func startGameTimer(){
        
        startInt -= 1
        //shakeLabel.text = String(startInt)
        
        if startInt == 0 {
            startTimer.invalidate()
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.game), userInfo: nil, repeats: true)
                
    
        }
        
    }
    
    
    @objc func game(){
        gameInt -= 1
        timeLabel.text = String(gameInt)
        
        if gameInt == 0{
            gameTimer.invalidate()
            
            //How to stop detecting shake motion???????????????????????????????????????????????????????????????
            //Stop adding shakeCounter?????????????????????????????????????????????????????????????????????????
            
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(GameViewController.end), userInfo: nil, repeats: false)
        }
    }
    
    @objc func end(){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
        self.present(vc, animated: false, completion: nil)
    }
    
}
