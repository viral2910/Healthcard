//
//  BookLabTest.swift
//  HealthCard
//
//  Created by Viral on 26/04/22.
//

import UIKit

class BookLabTest: UIViewController{
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var BtnLineRef: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        BtnLineRef.layer.borderColor = UIColor.init(hexString: "007AB8").cgColor
        BtnLineRef.layer.borderWidth = 2
        tableview.register(UINib(nibName: "BookLabTestCell", bundle: nil), forCellReuseIdentifier: "BookLabTestCell")
      

        // Do any additional setup after loading the view.
    }

    @IBAction func searchBtnAction(_ sender: Any) {
    }
}
extension BookLabTest : UITableViewDataSource ,UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableview.dequeueReusableCell(withIdentifier: "BookLabTestCell") as! BookLabTestCell
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
