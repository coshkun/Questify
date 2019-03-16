//
//  LuncherVC.swift
//  Questify
//
//  Created by Coskun Appwox on 16.03.2019.
//  Copyright © 2019 Coskun Appwox. All rights reserved.
//

import UIKit

class LuncherVC: BaseViewController {
    
    @IBOutlet weak var buttonContainer:UIView!
    @IBOutlet weak var startGameButton:UIButton!
    @IBOutlet weak var contactButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Colorize Page
        setupViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    func setupViews() {
        let grad = CAGradientLayer()
        grad.frame = self.view.bounds
        let colors = [RegisteredColors.darkSky.cgColor, RegisteredColors.deepSky.cgColor] //[UIColor.black.cgColor, UIColor.blue.cgColor, UIColor.magenta.cgColor]
        grad.colors = colors
        view.layer.insertSublayer(grad, at: 0)
        
        buttonContainer.layer.borderWidth = 1.0
        buttonContainer.layer.borderColor = UIColor.white.cgColor
        buttonContainer.layer.masksToBounds = true
        buttonContainer.layer.cornerRadius = 6.0
        
        startGameButton.layer.borderWidth = 1.0
        startGameButton.layer.borderColor = UIColor.white.cgColor
        startGameButton.layer.masksToBounds = true
        startGameButton.layer.cornerRadius = 4.0
        
        contactButton.layer.borderWidth = 1.0
        contactButton.layer.borderColor = UIColor.white.cgColor
        contactButton.layer.masksToBounds = true
        contactButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func startGameButton_Action(_ sender:UIButton!) {
        
    }
    
    @IBAction func contactButton_Action(_ sender:UIButton!) {
        
    }
    
}
