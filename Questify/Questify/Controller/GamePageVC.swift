//
//  GamePageVC.swift
//  Questify
//
//  Created by Coskun Appwox on 17.03.2019.
//  Copyright © 2019 Coskun Appwox. All rights reserved.
//

import UIKit

class GamePageVC: BaseViewController {
    
    @IBOutlet weak var quitButton:UIButton!
    @IBOutlet weak var remainingLifeButton:UIButton!
    @IBOutlet weak var remainingTimeLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        connectSokets() {
            // Do somethings related
        }
    }
    
    func setupViews() {
        let grad = CAGradientLayer()
        grad.frame = self.view.bounds
        let colors = [UIColor.black.cgColor, UIColor.blue.cgColor, UIColor.magenta.cgColor] //
        grad.colors = colors
        view.layer.insertSublayer(grad, at: 0)
    }

    func connectSokets(_ completion: (() -> ())? = nil ) {
        
        
        //when we finish, ivoke the closure
        completion?()
    }
}



extension GamePageVC {
    @IBAction func quitButton_Action(_ sender:UIButton!) {
        //But finish the Quiz First !!!
        navigationController?.popViewController(animated: true)
    }
}
