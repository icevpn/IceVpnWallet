//
//  IVPageView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/13.
//

import UIKit

protocol IVPageScrollViewDelegate{
    func scrollViewWillBeginDragging()
    func pageContentScrollView(index : Int)
}

extension IVPageScrollViewDelegate{
    func scrollViewWillBeginDragging(){}
}

class IVPageView: UIView {
    private var childs : [UIViewController] = []
    //开始的偏移量
    private var startOffsetX : CGFloat = 0
    private var isScroll = false
    private var isAnimated = false
    private var preVC : UIViewController?
    private var preIndex : Int = -1
    private var parentViewController : UIViewController!
    
    var delegate : IVPageScrollViewDelegate?
    
    
    convenience init(frame:CGRect,parentVC:UIViewController,childs:[UIViewController],isAnimated : Bool = true) {
        self.init(frame: frame)
        self.isAnimated = isAnimated
        self.childs = childs
        self.parentViewController = parentVC
        createUI()
    }
    
    func createUI(){
        self.addSubview(scrollView)
    }
    
    lazy var scrollView : IVPageScrollView = {
        let scrollView = IVPageScrollView(frame: self.bounds)
        scrollView.bounces = true
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.bounds.width * CGFloat(childs.count), height: 0)
        return scrollView
    }()
}

extension IVPageView : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        isScroll = true
        self.delegate?.scrollViewWillBeginDragging()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScroll = false
        let offsetX = scrollView.contentOffset.x
        if startOffsetX != offsetX{
            self.preVC?.beginAppearanceTransition(false, animated: false)
        }
        let index = Int(offsetX / scrollView.frame.size.width);
        let childVC = self.childs[index];
        
        var firstAdd = false;
        if (self.parentViewController.children.contains(childVC) == false) {
            self.parentViewController.addChild(childVC)
            firstAdd = true;
        }
        childVC.beginAppearanceTransition(true, animated: false)
        if (firstAdd) {
            self.scrollView.addSubview(childVC.view)
            childVC.view.frame = CGRectMake(offsetX, 0, self.frame.width, self.frame.height);
        }
        
        // 2.1、切换子控制器的时候，执行上个子控制器的 viewDidDisappear 方法
        if (startOffsetX != offsetX) {
            self.preVC?.endAppearanceTransition()
        }
        childVC.endAppearanceTransition()
        if (firstAdd) {
            childVC.didMove(toParent: self.parentViewController)
        }
        
        // 4.1、记录上个展示的子控制器、记录当前子控制器偏移量
        self.preVC = childVC;
        self.preIndex = index;
        self.delegate?.pageContentScrollView(index: index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (isAnimated == true && isScroll == false) {
            return;
        }
        var originalIndex = 0;
        var targetIndex = 0;
        // 2、判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x;
        let scrollViewW = scrollView.bounds.size.width;
        if (currentOffsetX > startOffsetX) { // 左滑
            //计算 originalIndex
            originalIndex = Int(currentOffsetX / scrollViewW);
            //计算 targetIndex
            targetIndex = originalIndex + 1;
            if (targetIndex >= self.childs.count) {
                targetIndex = self.childs.count - 1;
            }
            if (currentOffsetX - startOffsetX == scrollViewW) {
                targetIndex = originalIndex;
            }
        } else { // 右滑
            targetIndex = Int(currentOffsetX / scrollViewW);
            originalIndex = targetIndex + 1;
            if (originalIndex >= self.childs.count) {
                originalIndex = self.childs.count - 1;
            }
        }
        self.delegate?.pageContentScrollView(index: targetIndex)
    }
}

extension IVPageView{
    func setPageIndex(index : Int){
        let offsetX = CGFloat(index) * self.frame.width;
        if (self.preVC != nil && self.preIndex != index) {
            self.preVC?.beginAppearanceTransition(false, animated: false)
        }
        if (self.preIndex != index) {
            let childVC = self.childs[index];
            var firstAdd = false;
            if (self.parentViewController.children.contains(childVC) == false) {
                self.parentViewController.addChild(childVC)
                firstAdd = true;
            }
            childVC.beginAppearanceTransition(true, animated: false)
            
            if (firstAdd) {
                self.scrollView.addSubview(childVC.view)
                childVC.view.frame = CGRectMake(offsetX, 0, self.frame.width, self.frame.height);
                
            }
            
            // 1.1、切换子控制器的时候，执行上个子控制器的 viewDidDisappear 方法
            if (self.preVC != nil && preIndex != index) {
                self.preVC?.endAppearanceTransition()
            }
            childVC.endAppearanceTransition()
            if (firstAdd) {
                childVC.didMove(toParent: self.parentViewController)
            }
            // 3.1、记录上个子控制器
            self.preVC = childVC;
            self.scrollView.setContentOffset(CGPointMake(offsetX, 0), animated: isAnimated)
        }
        preIndex = index;
        startOffsetX = offsetX;
        
        
    }
}
