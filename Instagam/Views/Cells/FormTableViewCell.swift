//
//  FormTableViewCell.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/22/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

protocol FormTableViewCellDelegate:AnyObject {
    func formTableViewCell(_ cell:FormTableViewCell, didUpdateField updatedModel:EditProfileFormModel)
}
class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
 
    static let identifier  = "FormTableViewCell"
    private var model: EditProfileFormModel?
    
    public weak var delegate:FormTableViewCellDelegate?
    
    private let formLabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field :UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        selectionStyle = .none
        field.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    public func configureModel(with model:EditProfileFormModel){
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.with/3, height: contentView.height)
        field.frame = CGRect(x:formLabel.right + 5, y: 0, width: contentView.with-10 - formLabel.with, height: contentView.height)
    }
    
    //MARK:- Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField:model)
        textField.resignFirstResponder()
        return true
    }
    
}
