//
//  CharacterDetailController.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import UIKit

protocol CharacterDetailViewProtocol: ViewProtocol {
    var viewModel: CharacterDetailViewModelProtocol {get set}
}

class CharacterDetailController: BaseViewController, CharacterDetailViewProtocol {

    var viewModel: CharacterDetailViewModelProtocol

    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var thumbnail: UIImageView!

    init?(coder: NSCoder, viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        bind(to: viewModel)
        fetchCharacterDetails()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "character_detail_title".localizedString()
    }

    private func bind(to viewModel: CharacterDetailViewModelProtocol) {
        viewModel.name.observe(on: self, observerBlock: { name in self.name.text = name })
        viewModel.description.observe(on: self, observerBlock: { description in self.descriptionLabel.text = description })
        viewModel.thumbnail.observe(on: self, observerBlock: { thumbnailURL in
            self.thumbnail.kf.setImage(with: thumbnailURL, placeholder: UIImage(named: "defaultImage"))
        })
    }

    private func fetchCharacterDetails() {
        showSpinner()
        viewModel.fetchCharacterDetail(completion: { [weak self] result in
            guard let self = self else { return }
            self.hideSpinner()
            switch result {
            case .failure(let error):
                self.showErrorMessage(error: error.errorDescription)
            default:
                break
            }
        })
    }
}
