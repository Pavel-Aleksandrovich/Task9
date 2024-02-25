//
//  File.swift
//  task9
//
//  Created by pavel mishanin on 25/2/24.
//

import UIKit

final class ListColorsCollectionCell: UICollectionViewCell {
    
    static let id = String(describing: ListColorsCollectionCell.self)
    
    private let backColor = UIView()
    
    var widthConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    
    private var isFirst = true
    // init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isFirst {
            isFirst = false
            
            layer.cornerRadius = frame.height/2
            
            widthConstraint = backColor.widthAnchor.constraint(equalToConstant: frame.width)
            widthConstraint.isActive = true
            
            heightConstraint = backColor.heightAnchor.constraint(equalToConstant: frame.width)
            heightConstraint.isActive = true
            
            backColor.layer.cornerRadius = backColor.frame.height/2
        }
    }
    
    func setData(color: UIColor, isSelected: Bool, isSelectedPrevious: Bool) {
        backColor.backgroundColor = color
        
        let selectedWidth = isSelected ? (frame.width - 12) : frame.width
        
        layer.borderColor = color.cgColor
        
        // здесь выставили начальное значение
        layoutIfNeeded()
        widthConstraint.constant = frame.width
        heightConstraint.constant = frame.width
        backColor.layer.cornerRadius = frame.width/2
        layoutIfNeeded()
        
        if isSelectedPrevious && !isSelected {
            // Здесь ставим сначала значение как у выбранного элемента , а потом начальное
            widthConstraint.constant = frame.width - 12
            heightConstraint.constant = frame.width - 12
            backColor.layer.cornerRadius = (frame.width-12)/2
            
            self.layoutIfNeeded()
            UIView.animate(withDuration: 0.4) {
                self.widthConstraint.constant = self.frame.width
                self.heightConstraint.constant = self.frame.width
                self.backColor.layer.cornerRadius = self.frame.width/2
                self.layoutIfNeeded()
            }
        }
        
        if isSelected {
            scaleAnimation()
        }
        
        
        UIView.animate(withDuration: 0.4) {
            // если это выбранный элемент , то ставим значение как у выбранного
            self.widthConstraint.constant = selectedWidth
            self.heightConstraint.constant = selectedWidth
            self.backColor.layer.cornerRadius = selectedWidth/2
            self.layoutIfNeeded()
        }
    }
}

// MARK: - ConfigureView
private extension ListColorsCollectionCell {
    func configureView() {
        backgroundColor = .clear
        
        layer.borderWidth = 2//12
        
            contentView.addSubview(backColor)
        backColor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backColor.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backColor.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            backColor.topAnchor.constraint(equalTo: topAnchor, constant: 6),
//            backColor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
//            backColor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
//            backColor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
        ])
    }
}
