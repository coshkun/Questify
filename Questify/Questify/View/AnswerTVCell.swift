//
//  AnswerTVCell.swift
//  Questify
//
//  Created by Coskun Appwox on 17.03.2019.
//  Copyright © 2019 Coskun Appwox. All rights reserved.
//

import UIKit

class AnswerTVCell: UITableViewCell {
    
    @IBOutlet weak var frameBG:UIView!
    @IBOutlet weak var titleLB:UILabel!
    @IBOutlet weak var greenBG:UIView!
    @IBOutlet weak var redBG:UIView!
    
    @IBOutlet weak var tickLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundView = UIView() //clears white color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        setSelectedCellStyle()
    }
    
    func setSelectedCellStyle() {
        let bgColorView = UIView(frame: frame)
        bgColorView.backgroundColor = RegisteredColors.tintBlue.withAlphaComponent(0.45)
        selectedBackgroundView = bgColorView
    }
    
    
    
    var item:Answer! {
        didSet {
            guard item != nil else {return}
            titleLB.text = item.title
            updateSelection()
        }
    }
    
    func updateSelection() {
        tickLabel.isHidden = !item.isSelected
    }
    
    override func prepareForReuse() {
        titleLB.text = ""
        tickLabel.isHidden = true
        greenBG.isHidden = true
        redBG.isHidden = true
    }
}
