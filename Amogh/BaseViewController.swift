//
//  BaseViewController.swift
//  Amogh
//
//  Created by Amogh on 13/06/2020.
//  Copyright © 2020 Amogh. All rights reserved.
//

import UIKit
import JGProgressHUD



class BaseViewController: UIViewController {
    
    let hud = JGProgressHUD(style: .dark)


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showErrorAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
               
               
               let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                }
                     alertController.addAction(cancelAction)

               self.present(alertController, animated: true, completion: nil)
        
    }
    
    func showProgressHUD(title:String){
        hud.textLabel.text = title
        hud.show(in: self.view)

    }
    
    func hideProgressHUD(){
        hud.dismiss(animated: true)
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
