//
//  BookLabTestCell.swift
//  HealthCard
//
//  Created by Viral on 26/04/22.
//

import UIKit

protocol BookLabDelegate {
    func getTestId(value : [Int])
}

class BookLabTestCell: UITableViewCell {
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var consDrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    var delegate:BookLabDelegate!
    var labListData : [LabTestDtlslist] = []
    var selectedID : [Int] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "LabTestCell", bundle: nil), forCellReuseIdentifier: "LabTestCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension BookLabTestCell : UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "LabTestCell") as! LabTestCell
        cell.titleLabel.text = labListData[indexPath.row].labTestText
//        cell.subtitleLabel.text = labListData[indexPath.row].
        let url = URL(string: "\(labListData[indexPath.row].labTestImageURL)")!
        if selectedID.contains(labListData[indexPath.row].id)
        {
            cell.selectionImageView.image = UIImage(named: "checkedcircle");
        }
        else
        {
            cell.selectionImageView.image = UIImage(named: "circle");
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                cell.testImageView.image = image
            }
        }.resume()
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedID.contains(labListData[indexPath.row].id) {
            if let index = selectedID.firstIndex(of: labListData[indexPath.row].id) {
                selectedID.remove(at: index)
            }
        } else {
            selectedID.append(labListData[indexPath.row].id)
        }
        delegate.getTestId(value: selectedID)
        tableview.reloadData()
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
