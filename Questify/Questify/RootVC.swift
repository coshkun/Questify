//
//  ViewController.swift
//  Questify
//
//  Created by Coskun Appwox on 16.03.2019.
//  Copyright © 2019 Coskun Appwox. All rights reserved.
//

import UIKit

class RootVC: BaseViewController {
    static let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootVC") as! RootVC
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) { super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil) }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    //let masterPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MasterTabBarVC") as! MasterTabBarVC
    var navigation:MainNavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        debugFontsSupported()
        debugDocumentsDirectory()
        debugUserDefaults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        connectToServices()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    
    // MARK - NAVIGATIONS:Push
    public func pushVC(named:String, animated:Bool = true) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: named) {
            navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    // MARK - NAVIGATIONS:Present
    public func presentVC(named:String, animated:Bool = true, completion: (() -> Void)? = nil) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: named) {
            navigationController?.present(vc, animated: animated, completion: completion)
        }
    }


}





// MARK: - SERVICE CONNECTORS
extension RootVC {
    
    func connectToServices() {
        // Do any REST based authentication/auto-login jobs here..
        
        // And then push to mainPageVC
        pushVC(named: "LuncherVC")
    }
}









// MARK: - PRINCIPAL NAVCONS
class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 221/255.0, green: 4/255.0, blue: 43/255.0, alpha: 1.0) //primaryRed
        isNavigationBarHidden = true
    }
    
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        return .lightContent
    //    }
    
    // this one locks the device to Portraid orientation from root
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
}
