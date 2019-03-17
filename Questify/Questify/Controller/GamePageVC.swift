//
//  GamePageVC.swift
//  Questify
//
//  Created by Coskun Appwox on 17.03.2019.
//  Copyright © 2019 Coskun Appwox. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON

class GamePageVC: BaseViewController {
    
    @IBOutlet weak var quitButton:UIButton!
    @IBOutlet weak var remainingLifeButton:UIButton!
    @IBOutlet weak var remainingTimeLabel:UILabel!
    @IBOutlet weak var questionCounterLB:UILabel!
    @IBOutlet weak var questionLabel:UILabel!
    @IBOutlet weak var tableContainer:UIView!
    
    @IBOutlet weak var tableView:UITableView!
    
    //Data Relateds
    var dataSource:[Answer]! = [Answer]()
    let kMaxPlayerLife = 3 // <- we use this to reset UI
    let kMaxRemainingTimeInSec = 20 // <- also resets UI
    var questionCount = 0
    var hasAnswered = false //this gives user some space before evaluation
    
    let cell_id     = "AnswerTVCell_id"
    let cell_height = CGFloat(56.0)

    
    //Socket Relateds
    let sessionToken:String = UUID().uuidString.replacingOccurrences(of: "-", with: "")
    var manager: SocketManager!
    var socket:SocketIOClient!
    var isConnected = false
    
    
    ////////////////////////////////////////////// START LOADING //////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //register custum cell
        tableView.register(UINib(nibName: "AnswerTVCell", bundle: nil), forCellReuseIdentifier: cell_id)
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
        setupViews()
        clearUI()
        connectSokets() {
            // Do somethings related
            self.reloadUI()
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
        socket.disconnect()
        navigationController?.popViewController(animated: true)
    }

    
}




//////////////////////////////////////
// Socket JOBS & Business Logic
//
extension GamePageVC {
    func connectSokets(_ completion: (() -> ())? = nil ) {
        //Create Socketio instances first
        manager = SocketManager(socketURL: URL(string: "http://localhost:5000/")!,
                                config: [.log(false), .connectParams(["token" : sessionToken ])] )
        socket = manager.defaultSocket
        
        registerHandlers()
        
        socket.on(clientEvent: .connect) { [weak self] data, ackEmitter in
            self?.isConnected = true
            print("*** Socket Server Connected ***")
            self?.socket.emit("hello", with: ["hello server"] )
        }
        
        socket.connect()
        
        //when we finish, ivoke the closure
        completion?()
    }
    
    func getCurrentQuestion() -> Question? {
        //magic happens here
        if let current = DataContext.shared.currentQuestion { return current }
        //else
        guard DataContext.shared.questions.count > 0 else {return nil}
        let first = DataContext.shared.questions.removeFirst()
        //questionCount += 1   // <-we will remove this later, user must answer first
        DataContext.shared.currentQuestion = first
        return first
    }
    
    func reloadUI() {
        //fill the UI data here..
        if let current = getCurrentQuestion() {
            questionLabel.text = current.title
            setLifeWith(kMaxPlayerLife)
            setRemainingTime(kMaxRemainingTimeInSec)
            setCurrentQuestion(questionCount, In: DataContext.shared.questions.count + 1) // +1 is the current question
            dataSource = current.answers
            tableView.reloadData()
            tableView.isUserInteractionEnabled = true //unlocks
        } else {
            clearUI()
        }
    }
    
    func clearUI(){ // this may renamed as 'resetUI' if you want to totaly clear everything
        tableView.isUserInteractionEnabled = true
        setLifeWith(kMaxPlayerLife)
        setRemainingTime(kMaxRemainingTimeInSec)
        setCurrentQuestion(0, In: dataSource.count)
        questionLabel.text = "Waitng for next question!"
        dataSource = [Answer]() //cleans the table
        tableView.reloadData()
    }
    
    func evaluateAnswer(_ answer:Answer, _ indexPath:IndexPath) {
        //if hasAnswered { return } // answer every question just one time
        
        let cell = tableView.cellForRow(at: indexPath) as! AnswerTVCell
        if answer.isSelected == answer.isCorrect {
            cell.greenBG.isHidden = false
        } else {
            cell.redBG.isHidden = false
        }
        tableView.isUserInteractionEnabled = false
        
        //show user the answer 5sec and jump next question
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            DataContext.shared.currentQuestion = nil
            self.reloadUI()
        }
        
        //hasAnswered = true
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
// Socket IO Event Handlers
//
extension GamePageVC {
    func registerHandlers() {
        
        socket.on("startGame") { data, ackEmiter in
            self.startGameHandler()
            return
        }
        
        socket.on("new_question") { data, ackEmitter in    // [weak self] data,
            self.handleNewQuestion(data[0])
        }
        
        // if we are Debuging or want to capture everything
        socket.onAny { print("Received Event: \($0.event)") }  //with items => \(JSON($0.items ?? [""]).rawString()!)
    }
    
    //MARK: - EVENT HANDLERS
    func startGameHandler() {
        
    }
    
    func handleNewQuestion(_ data:Any) {
        let json = JSON(arrayLiteral: data) // else {return}
        //hendle errors if any
        guard json.count > 0,
              json["status"].intValue  == 0 // <- this guy is success state
        else {
            print("*** Socket Server Error: ", json["errorText"].stringValue )
            return
        }
        
        //get new quest
        guard let newQ = Question(json: json[0]["response"]) // <- Parsing occurs in Object
        else {
            print("*** Question Parsing Err.")
            return
        }
        
        //add it to our cache
        DataContext.shared.questions.append(newQ)
        DataContext.shared.saveAllChanges()
        //finaly update UI
        reloadUI()
        
        print("*** Qustion Received:", newQ ) //Debug
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
        hasAnswered = false // <- ignores previous dispatch tasks (if exist)
        
        clearAllSelections()
        let cell = tableView.cellForRow(at: indexPath) as! AnswerTVCell
        dataSource[indexPath.row].isSelected = !dataSource[indexPath.row].isSelected //toogles
        cell.item = dataSource[indexPath.row] //updates cell
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { // gives user 5sec to change his choice
//            self.evaluateAnswer(self.dataSource[indexPath.row], indexPath)
//        }
        
        //it wont work healty, just get the answer and lock UI
        self.evaluateAnswer(self.dataSource[indexPath.row], indexPath)
        tableView.isUserInteractionEnabled = false
    }
    
    func clearAllSelections() {
        for i in 0 ..< dataSource!.count { dataSource[i].isSelected = false }
        tableView.reloadData()
    }
    
}
