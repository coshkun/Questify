//
//  BaseViewController.swift
//  Questify
//
//  Created by Coskun Caner on 16.03.2019.
//  Copyright © 2019 Coskun Caner. All rights reserved.
//
//  For whoom wondering, what is this page for:
//  This page is my Base Controller, my all Controllers inherits this class,
//  so they can share all mutual properties/functions. See line:24 for example
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Let set StatusBar for all sub controllers
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




// MARK: - Helper Base Classes
class BaseTVCell: UITableViewCell {
    
    var delegate:Any!
    
    func setupViews() { setSelectedCellStyle() }
    
    func setSelectedCellStyle() {
        let bgColorView = UIView(frame: frame)
        bgColorView.backgroundColor = RegisteredColors.tintBlue.withAlphaComponent(0.35)
        selectedBackgroundView = bgColorView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}

class BaseCollViewCell: UICollectionViewCell {
    
    var delegate:Any!
    
    func setupViews() { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}
