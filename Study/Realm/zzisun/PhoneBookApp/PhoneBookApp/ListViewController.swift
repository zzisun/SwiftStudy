//
//  ViewController.swift
//  PhoneBookApp
//
//  Created by 김지선 on 2021/11/02.
//

import UIKit
import RxCocoa
import RxSwift

final class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var disposeBag = DisposeBag()
    let DBSubject = BehaviorSubject<[Person]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        bindInput()
        bindOutput()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "연락처"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func magicButtonTouched(_ sender: Any) {
        let id = UUID().uuidString
        let me = Person(id: id, firstName: "Smith", lastName: "Kim", phoneNumber: "010-1234-1234", age: 20, work: "home")
        DBManager.shared.add(person: me)
        bindInput()
        bindOutput()
    }
    
    @IBAction func popButtonTouched(_ sender: Any) {
        let first = DBManager.shared.fetch()[0]
        DBManager.shared.delete(person: first)
        bindInput()
        bindOutput()
    }
    private func bindInput() {
        print(DBManager.shared.fetchRx())
        DBManager.shared.fetchRx().bind(to: DBSubject).disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        DBSubject
            .bind(to: tableView.rx.items(cellIdentifier: PersonCell.id,
                                         cellType: PersonCell.self)) { index, person, cell in
                print(person)
                cell.configure(person: person)
            }.disposed(by: disposeBag)
    }
}

//extension ListViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        DBManager.shared.fetch().count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
//        let person = DBManager.shared.fetch()[indexPath.row]
//        cell.configure(person: person)
//
//        return cell
//    }
//}

