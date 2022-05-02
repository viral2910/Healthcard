//
//  MyConsultation.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class MyConsultation: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .clear
        tableView.register(UINib(nibName: "MyConsultationCell", bundle: nil), forCellReuseIdentifier: "MyConsultationCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
}


extension MyConsultation: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyConsultationCell", for: indexPath)as! MyConsultationCell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
