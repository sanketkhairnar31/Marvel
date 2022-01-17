//
//  CharacterCell.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import UIKit
import Kingfisher

final class CharacterCell: UITableViewCell {
    
    @IBOutlet private weak var thumbnail: UIImageView!
    @IBOutlet private weak var name: UILabel!
    
    func setup(_ cellViewModel: CharacterCellViewModel?) {
        guard let viewModel = cellViewModel else { return }
        name.text = viewModel.name
        thumbnail.kf.setImage(with: viewModel.thumbnailURL, placeholder: UIImage(named: "defaultImage"))
    }
}
