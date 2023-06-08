//
//  ViewController.swift
//  TestDemo
//
//  Created by Sparkout on 05/06/23.
//

import UIKit

enum TestRestaurant: CaseIterable {
    case near
    case banner
}

class TestViewController: UIViewController {

    @IBOutlet weak var testTableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    let viewModel: TestViewModel = TestViewModel()
    var responseData: [Restaurant] = []
   // let testRestaurant: TestRestaurant = .near
    var indexpath: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTableView.delegate = self
        testTableView.dataSource = self
        testTableView.registerNib(NearTableViewCell.self)
        testTableView.registerNib(BannerTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataResponse()
    }
    
    func dataResponse() {
        viewModel.responseDetails { response, error in
            if let responseValue = response {
                self.responseData = responseValue
                
            }
            DispatchQueue.main.async {
                self.testTableView.reloadSections(IndexSet(integer: self.indexpath), with: .automatic)
            }
        }

    }

}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestRestaurant.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        indexpath = indexPath.section
        if indexPath.row == 0 {
            let cell: NearTableViewCell = tableView.dequeueReusableCell(NearTableViewCell.self, indexPath: indexPath)
            cell.viewModel = responseData
            cell.nearCollectionView.reloadData()
            return cell
        } else {
            if responseData.count > 0 {
                let cell: BannerTableViewCell = tableView.dequeueReusableCell(BannerTableViewCell.self, indexPath: indexPath)
                cell.viewModel = responseData
                cell.bannerCollectionView.reloadData()
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return responseData.count > 0 ? 150.0 : 0.0
    }
}
