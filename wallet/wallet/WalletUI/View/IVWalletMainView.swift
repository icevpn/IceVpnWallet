//
//  IVWalletMainView.swift
//  ICE VPN
//
//  Created by tgg on 2023/6/22.
//

import UIKit

class IVWalletMainView: UIView {
    
    var isNFT = false
    
    var changChainBlock : (()->())?
    var manageBlock : (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(IVWalletMainHeadItem.self, forCellWithReuseIdentifier: "IVWalletMainHeadItem")
        collectionView.register(IVWalletTokenItem.self, forCellWithReuseIdentifier: "IVWalletTokenItem")
        collectionView.register(IVNFTItem.self, forCellWithReuseIdentifier: "IVNFTItem")
        collectionView.register(IVWalletHeadReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "IVWalletHeadReusableView")
        return collectionView
    }()
    
    var model : Account?{
        didSet{
            self.updateBackground()
            self.collectionView.reloadData()
        }
    }
    
    func updateBackground() {
        if isNFT && self.model?.nfts?.count ?? 0 == 0{
            self.collectionView.backgroundView = IVPlaceholder.show(.empty,centerY: 100.w)
            return
        }
        self.collectionView.backgroundView = nil
    }
    
}



extension IVWalletMainView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        
        if isNFT{
            return self.model?.nfts?.count ?? 0
        }
        
        return self.model?.tokens?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IVWalletMainHeadItem", for: indexPath) as! IVWalletMainHeadItem
            cell.model = self.model
            cell.changChainBlock = self.changChainBlock
            cell.manageBlock = self.manageBlock
            cell.switchWallectBlock = {
                
            }
            
            return cell
        }
        
        if isNFT{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IVNFTItem", for: indexPath) as! IVNFTItem
            cell.model = self.model?.nfts?[indexPath.row]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IVWalletTokenItem", for: indexPath) as! IVWalletTokenItem
        cell.model = self.model?.tokens?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize.zero
        }
        return CGSize(width: Screen_width, height: 40.w)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 1{
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "IVWalletHeadReusableView", for: indexPath) as! IVWalletHeadReusableView
            view.typeBlock = {index in
                self.isNFT = index == 1
                self.updateBackground()
                self.collectionView.reloadData()
            }
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            return
        }
        if isNFT{
            return
        }
        IVRouter.to(name: .tokenDetail,params: ["token":self.model?.tokens?[indexPath.row]])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: Screen_width, height: 226.w)
        }
        if isNFT {
            return CGSize.init(width: Screen_width/2.0 - ceil(16.w*2), height: 160.w)
        }
        return CGSize.init(width: Screen_width, height: 71.w)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 || !isNFT{
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets.init(top: 0, left: 16.w, bottom: 0, right: 16.w)
    }
}
