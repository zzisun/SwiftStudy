//
//  View.swift
//  VIPER_Example
//
//  Created by Lia on 2021/11/09.
//

import UIKit

/*
 View : UI관련 처리만 하는 역할
    - Presenter에게 이벤트를 넘겨주고
    - Presenter에게 데이터를 받아 업데이트함

    - 여기서 viewModel은 정말 모델, 값을 의미함
 */

class CarsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CarsPresenterProtocol!
    var viewModels: [CarViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Presenter에게 데이터 받아서 View를 업데이트함
        // Presenter는 Interactor을 통해 데이터를 받음
        presenter.showCars { (viewModels) in
            self.viewModels = viewModels
            tableView.reloadData()
        }
    }
    
    // 이벤트를 Presenter에게 넘김
    // Presenter는 Router에게 넘겨서 화면 전환을 함
    @IBAction func createNewCar(_ sender: UIButton) {
        presenter.showCreateCarScreen()
    }
}


extension CarsViewController: UITableViewDelegate {
    // 이벤트를 Presenter에게 넘김
    // Presenter는 Router에게 넘겨서 화면 전환을 함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCarDetail(for: viewModels[indexPath.row])
    }
}


extension CarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carTableViewCell", for: indexPath)
        let viewModel = viewModels[indexPath.row]
        
        cell.textLabel?.text = viewModel.model
        cell.detailTextLabel?.text = viewModel.make
        
        return cell
    }
}



class CarDetailViewController : UIViewController {
    var presenter: CarsPresenterProtocol!
    var viewModel: CarViewModel!
}
