//
//  UserDetailsViewController.swift
//  TestApp
//
//  Created by ICS on 22/05/21.
//

import UIKit

enum ListTypes {
    case Name
    case UserName
    case Phone
    case Email
    case Website
    case Address
    case Company
}

class UserDetailsViewController: UIViewController {
    var userDetails: UserList!
    var listTypes: [ListTypes] = [.Name, .UserName, .Phone, .Email, .Website, .Address, .Company]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = userDetails.value(forKey: "name")  as? String
    }
}

//MARK: TableView Data source
extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userDetailsCell", for: indexPath as IndexPath)
        let lblKey : UILabel = cell.viewWithTag(1) as! UILabel
        let lblValue : UILabel = cell.viewWithTag(2) as! UILabel
        let item = listTypes[indexPath.row]
        
        switch item {
        case .Name:
            lblKey.text = "Name"
            lblValue.text = userDetails.value(forKey: "name")  as? String
        case .UserName:
            lblKey.text = "User Name"
            lblValue.text = userDetails.value(forKey: "username")  as? String
        case .Phone:
            lblKey.text = "Phone Number"
            lblValue.text = userDetails.value(forKey: "phone")  as? String
        case .Email:
            lblKey.text = "Email Address"
            lblValue.text = userDetails.value(forKey: "email")  as? String
        case .Website:
            lblKey.text = "Website"
            lblValue.text = userDetails.value(forKey: "website")  as? String
        case .Address:
            lblKey.text = "Address"
            let address = userDetails.value(forKey: "address")  as? AddressData
            let street = address?.value(forKey: "street")  as? String ?? ""
            let suite = address?.value(forKey: "suite")  as? String ?? ""
            let city = address?.value(forKey: "city")  as? String ?? ""
            let zipCode = address?.value(forKey: "zipcode")  as? String ?? ""
            lblValue.text = street + " " + suite + " " + city + " " + zipCode
        case .Company:
            lblKey.text = "Company"
            let company = userDetails.value(forKey: "company")  as? Company
            lblValue.text = company?.value(forKey: "name")  as? String ?? ""
        }
        return cell
    }
}
