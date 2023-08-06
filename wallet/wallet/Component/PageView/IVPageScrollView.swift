//
//  IVPageScrollView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit



class IVPageScrollView: UIScrollView {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !isPanBack(gestureRecognizer)
    }
    
    func isPanBack(_ tap : UIGestureRecognizer) -> Bool {
        if (self.contentOffset.x == 0) {
            if (tap == self.panGestureRecognizer) {
                let veloctiy = self.panGestureRecognizer.velocity(in: tap.view);
                if (veloctiy.x > 0) {
                    return  true;
                }
            }
        }
        return false;
    }

}
