//
//  HomeViewController.swift
//  TestApp
//
//  Created by ICS on 21/05/21.
//

import UIKit
import ANActivityIndicator
import RealmSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var tblUserList: UITableView!
    fileprivate var userList = [UserList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User List"
        loadAPI()
    }
    
    private func loadAPI() {
        ANActivityIndicatorPresenter.shared.showIndicator()
        APiClass.apiGetTaskList(mainUrl: "https://jsonplaceholder.typicode.com/users") { (respose,error) in
            ANActivityIndicatorPresenter.shared.hideIndicator()
            if error != nil{
                TestAppGlobal.sharedInstance.showGeneralAlert(message: "There may be a problem in your internet connection. List not updated from server", view: self)
                self.loadData()
            } else {
                self.cleanData()
                self.saveData(data: respose ?? [])
                self.loadData()
            }
        }
    }
    
    private func saveData(data: [UserList]) {
        //Save values to the DB
        let realm = try! Realm()
        try! realm.write {
            realm.add(data)
        }
    }
    
    private func loadData() {
        //Get values from DB
        let realm = try! Realm()
        let data = Array(realm.objects(UserList.self))
        userList = [UserList](data)
        tblUserList.reloadData()
    }
    
    private func cleanData() {
        //Clean the DB for new data updates
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(UserList.self))
        }
    }
}

//MARK: TableView Data source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userListCell", for: indexPath as IndexPath)
        let lblName : UILabel = cell.viewWithTag(1) as! UILabel
        let lblPhone : UILabel = cell.viewWithTag(2) as! UILabel
        lblName.text = userList[indexPath.row].value(forKey: "name")  as? String
        lblPhone.text = userList[indexPath.row].value(forKey: "phone")  as? String
        return cell
    }
}

//MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userDetailView") as? UserDetailsViewController {
            vc.userDetails = userList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
