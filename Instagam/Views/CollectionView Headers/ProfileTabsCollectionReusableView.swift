//
//  ProfileTabsCollectionReusableView.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/22/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate:AnyObject {
    func didTapGridButtonTab()
    func didTapTagButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    struct Constant {
        static let padding:CGFloat = 8
    }
    
    public weak var delegate:ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton:UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    private let tagButton:UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(gridButton)
        addSubview(tagButton)
        
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(didTapTagButton), for: .touchUpInside)
    }
    
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        tagButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    @objc private func didTapTagButton(){
        tagButton.tintColor = .systemBlue
        gridButton.tintColor = .lightGray
        delegate?.didTapTagButtonTab()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - Constant.padding*2
        let gridButtonX = (with/2 - size)/2
        
        gridButton.frame = CGRect(x: gridButtonX, y: Constant.padding, width: size-2, height: size-2)
        tagButton.frame = CGRect(x: gridButtonX + with/2, y: Constant.padding, width: size-2, height: size-2)
    }
}
