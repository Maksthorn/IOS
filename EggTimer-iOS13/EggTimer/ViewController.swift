//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let eggTimes = ["Soft":300, "Hard":720, "Medium":420]
    var secondsLeft = 60
    var timer = Timer()
    var totlaTime = 0
    var secPassed = 0
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        // resets/creates timer when called/pressed
        let hardness = sender.currentTitle!
        // ! removes safety check
        totlaTime = eggTimes[hardness]!
        
        Timer.scheduledTimer(timeInterval: 1.0,target: self,selector:#selector(updateTimer),userInfo:nil, repeats: true)
    }
    // selector comes from obj c
    @objc func updateTimer(){
        if secPassed < totlaTime{
            let progress = secPassed/totlaTime
            progressBar.progress = Float(progress)
            secondsLeft += 1
        } else{
            timer.invalidate()
            titleLabel.text = "Done"
        }
    }
    
}