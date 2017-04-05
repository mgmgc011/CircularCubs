//
//  ViewController.swift
//  Circular
//
//  Created by Mingu Chu on 4/5/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var chicagoButton: UIButton!

    let transition = CircularMotion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chicagoButton.layer.cornerRadius = chicagoButton.frame.width / 2
        // Do any additional setup after loading the view, typically from a nib.
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = chicagoButton.center
        transition.circleColor = chicagoButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = chicagoButton.center
        transition.circleColor = chicagoButton.backgroundColor!
        
        return transition
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cubsVC = segue.destination as! CubsViewController
        cubsVC.transitioningDelegate = self
        cubsVC.modalPresentationStyle = .custom
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

