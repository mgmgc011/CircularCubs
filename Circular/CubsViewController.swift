//
//  CubsViewController.swift
//  Circular
//
//  Created by Mingu Chu on 4/5/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit

class CubsViewController: UIViewController {

    @IBOutlet weak var cubsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cubsButton.layer.cornerRadius = cubsButton.frame.width / 2
        
        // Do any additional setup after loading the view.
    }
    @IBAction func cubsButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
