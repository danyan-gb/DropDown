//
//  DropDownCellTableViewCell.swift
//  DropDown
//
//  Created by Kevin Hirsch on 28/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

#if os(iOS)

import UIKit

open class DropDownCell: UITableViewCell {
		
	//UI
	@IBOutlet open weak var optionLabel: UILabel!
    open var customOptionLabel: UILabel?
	
	var selectedBackgroundColor: UIColor?
    var highlightTextColor: UIColor?
    var normalTextColor: UIColor?

}

// MARK : DEFAULT CELL PROPERTIES
public extension DropDownCell {
    static var defaultReuseIdentifier: String {
        DPDConstant.ReusableIdentifier.DropDownCell
    }
}

//MARK: - UI

extension DropDownCell {
	
	override open func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = .clear
	}
	
	override open var isSelected: Bool {
		willSet {
			setSelected(newValue, animated: false)
		}
	}
	
	override open var isHighlighted: Bool {
		willSet {
			setSelected(newValue, animated: false)
		}
	}
	
	override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
		setSelected(highlighted, animated: animated)
	}
	
	override open func setSelected(_ selected: Bool, animated: Bool) {
        let activeLabel = customOptionLabel != nil ? customOptionLabel : optionLabel

		let executeSelection: () -> Void = { [weak self] in
			guard let `self` = self else { return }

			if let selectedBackgroundColor = self.selectedBackgroundColor {
				if selected {
					self.backgroundColor = selectedBackgroundColor
                    activeLabel?.textColor = self.highlightTextColor
				} else {
					self.backgroundColor = .clear
                    activeLabel?.textColor = self.normalTextColor
				}
			}
		}
		
		if animated {
			UIView.animate(withDuration: 0.3, animations: {
				executeSelection()
			})
		} else {
			executeSelection()
		}

		accessibilityTraits = selected ? .selected : .none
	}
	
}

#endif
