//
//  EmailLoginViewController.swift
//  MoMo
//
//  Created by 초이 on 2021/01/12.
//

import UIKit

class EmailLoginViewController: UIViewController {

    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessageTop: NSLayoutConstraint!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButtonTop: NSLayoutConstraint!
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
