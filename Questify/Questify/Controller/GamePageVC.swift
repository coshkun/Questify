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
    @IBOutlet weak var questionCounterLB:UILabel!
    @IBOutlet weak var questionLabel:UILabel!
    @IBOutlet weak var tableContainer:UIView!
    
    @IBOutlet weak var tableView:UITableView!
    
    var item: Question! = Question()
    
    var dataSource:[Answer]! = [ Answer(id:0, title:"Option A", isSelected:false, isCorrect:true),
                                 Answer(id:0, title:"Option B", isSelected:false, isCorrect:true),
                                 Answer(id:0, title:"Option C", isSelected:false, isCorrect:true),
                                 Answer(id:0, title:"Option D", isSelected:false, isCorrect:true)]
    let kMaxPlayerLife = 3 // <- we use this to reset UI
    let kMaxRemainingTimeInSec = 20 // <- also resets UI
    
    let cell_id     = "AnswerTVCell_id"
    let cell_height = CGFloat(56.0)

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //register custum cell
        tableView.register(UINib(nibName: "AnswerTVCell", bundle: nil), forCellReuseIdentifier: cell_id)
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
        setupViews()
        connectSokets() {
            // Do somethings related
            self.clearUI()
        }
    }
    
    func setupViews() {
        let grad = CAGradientLayer()
        grad.frame = self.view.bounds
        let colors = [UIColor.black.cgColor, UIColor.blue.cgColor, UIColor.magenta.cgColor] //
        grad.colors = colors
        view.layer.insertSublayer(grad, at: 0)
    }
    
    @IBAction func quitButton_Action(_ sender:UIButton!) {
        //But finish the Quiz First !!!
        navigationController?.popViewController(animated: true)
    }

    
}




//////////////////////////////////////
// Socket JOBS & Business Logic
//
extension GamePageVC {
    func connectSokets(_ completion: (() -> ())? = nil ) {
        
        
        //when we finish, ivoke the closure
        completion?()
    }
    
    func reloadUI() {
        clearUI()
    }
    
    func clearUI(){ // this may renamed as 'resetUI' if you want to totaly clear everything
        setLifeWith(kMaxPlayerLife)
        setRemainingTime(kMaxRemainingTimeInSec)
        setCurrentQuestion(0, In: dataSource.count)
        questionLabel.text = "Waitng for next question!"
    }
    
    func setLifeWith(_ count:Int) {
        guard count >= 0 && count < 4 else {return}
        switch count {
        case 0:
            remainingLifeButton.setTitle("", for: .normal)
        case 1:
            remainingLifeButton.setTitle("♥︎", for: .normal)
        case 2:
            remainingLifeButton.setTitle("♥︎ ♥︎", for: .normal)
        case 3:
            remainingLifeButton.setTitle("♥︎ ♥︎ ♥︎", for: .normal)
        default:
            remainingLifeButton.setTitle("", for: .normal) // never falls here, we already guarded
        }
    }
    func setRemainingTime(_ seconds:Int) {
        remainingTimeLabel.text = "Remainig time: \(seconds)sn"
    }
    func setCurrentQuestion(_ count:Int, In:Int = 0) {
        guard count >= 0 && count <= In else {
            if In == 0 { questionCounterLB.text = "Quest: \(count)"; return }
            questionCounterLB.text = "Quest: --/--" //if the numbers faills
            return
        }
        
        questionCounterLB.text = "Quest: \(count)/\(In)" //on success
    }
}









//////////////////////////////////////
// Answer Table Delegates
//
extension GamePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as! AnswerTVCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cell_height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        clearAllSelections()
        let cell = tableView.cellForRow(at: indexPath) as! AnswerTVCell
        dataSource[indexPath.row].isSelected = !dataSource[indexPath.row].isSelected //toogles
        cell.item = dataSource[indexPath.row] //updates cell
    }
    
    func clearAllSelections() {
        for i in 0 ..< dataSource!.count { dataSource[i].isSelected = false }
        tableView.reloadData()
    }
    
}
