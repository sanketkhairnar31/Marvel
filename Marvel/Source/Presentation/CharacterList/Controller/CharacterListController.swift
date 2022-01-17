//
//  CharacterListController.swift
//  Marvel
//
//  Created by Sanket Khairnar on 06/12/21.
//  Copyright © 2021 Globant. All rights reserved.
//

import UIKit

protocol CharacterListViewProtocol: ViewProtocol {
    var viewModel: CharacterListViewModelProtocol {get set}
}

class CharacterListController: BaseViewController, CharacterListViewProtocol {

    @IBOutlet private weak var tableView: UITableView!
    var viewModel: CharacterListViewModelProtocol
    
    required init?(coder: NSCoder, viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpTableView()
        fetchCharacterList()
    }

    private func setUpNavigation() {
        navigationItem.title = "character_list_title".localizedString()
    }

    private func setUpTableView() {
        tableView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 120
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 1
        tableView.estimatedSectionFooterHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 1
    }
    
    private func fetchCharacterList() {
        showSpinner()
        viewModel.fetchCharacterList(completion: { [weak self] result in
            guard let self = self else { return }
            self.hideSpinner()
            switch result {
            case .success( _):
                self.tableView.reloadData()
            case .failure(let error):
                self.showErrorMessage(error: error.errorDescription)
            }
        })
    }
}

extension CharacterListController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterCell else {
            return UITableViewCell()
        }
        cell.setup(viewModel.getCharacterCellViewModel(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.navigateToDetailScene(self, indexPath: indexPath)
    }
}

extension CharacterListController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let boundsHeight = scrollView.bounds.height
        let scrollPosY = scrollView.contentOffset.y
        if contentHeight <= scrollPosY + boundsHeight {
            scrollToBottom()
        }
    }

    private func scrollToBottom() {
        showSpinner()
        viewModel.loadMoreData(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success( _):
                self.tableView.reloadData()
            case .failure(let error):
                self.showErrorMessage(error: error.errorDescription)
            }
        })
    }
}
