//
//  MeCardView.swift
//  DataSimulation
//
//  Created by Aiewing on 2020/12/5.
//

import UIKit

class MeCardView: UIView {

    func setCardInfo(title: String, titleList: [String], imageList: [String]) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadSettings()
        loadUI()
    }
    
    func loadSettings() {
        
    }
    
    func loadUI() {
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.label("", TextBlackColor, TextBoldFont(25))
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
