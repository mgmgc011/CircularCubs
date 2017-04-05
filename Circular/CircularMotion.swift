//
//  CircularMotion.swift
//  Circular
//
//  Created by Mingu Chu on 4/5/17.
//  Copyright © 2017 Chingoo. All rights reserved.
//

import UIKit

class CircularMotion: NSObject {

    
    var circle = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.black
    
    var duration = 0.3
    
    enum CircularTransitionMode: Int {
        case present, dismiss, pop
    }

    var transitionMode: CircularTransitionMode = .present

}


extension CircularMotion: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: .to) {
                
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                circle.frame = frameForCirlce(withViewCenter: viewCenter, size: viewSize, startingPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)

                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: { 
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                    
                }, completion: { (completed:Bool) in
                    transitionContext.completeTransition(completed)
                })
            }
            
        }else{
            
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returingView = transitionContext.view(forKey: transitionModeKey) {
                
                let viewCenter = returingView.center
                let viewSize = returingView.frame.size
                
                circle.frame = frameForCirlce(withViewCenter: viewCenter, size: viewSize, startingPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: { 
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returingView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returingView.center = self.startingPoint
                    returingView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(returingView, belowSubview: returingView)
                        containerView.insertSubview(self.circle, belowSubview: returingView)
                    }
                    
                    
                }, completion: { (completed:Bool) in
                    returingView.center = viewCenter
                    returingView.removeFromSuperview()
                    
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(completed)
                })
            }
        }
    }
    
    
    func frameForCirlce(withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startingPoint:CGPoint) -> CGRect {
        let xLength = fmax(startingPoint.x, viewSize.width - startingPoint.x)
        let yLength = fmax(startingPoint.y, viewSize.height - startingPoint.y)
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
}
