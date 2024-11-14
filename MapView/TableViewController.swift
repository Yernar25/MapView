//
//  TableViewController.swift
//  MapView
//
//  Created by Yernar Dyussenbekov on 14.11.2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    
    
    var hotelArray = [
        Hotel(name: "Cupertino Hotel", adres: "10889 North De Anza Boulevard, Купертино, CA 95014", rating: 5, price: 120, commentAmount: 34, geoLat: 37.33549096249938, geoLong: -122.03324150076332, img: "Cupertino Hotel"),
        
        Hotel(name: "Aloft Cupertino", adres: "10165 North De Anza Blvd, Купертино, CA 95014", rating: 4.3 , price: 120, commentAmount: 34, geoLat: 37.32536498780106, geoLong: -122.03306658114016, img: "Aloft Cupertino"),
        
        Hotel(name: "2BR APT", adres: "1605 Ontario Drive, Саннивейл, CA 94087", rating: 4.7, price: 80, commentAmount: 45, geoLat: 37.340779091480556, geoLong: -122.04003242238466, img: "2BR APT"),
        
        Hotel(name: "Juniper Hotel Cupertino", adres: "10050 South De Anza Boulevard, Купертино, CA 95014", rating: 4.9, price: 230, commentAmount: 21, geoLat: 37.321365239122954, geoLong: -122.03147986638947, img: "Juniper Hotel"),
        
        Hotel(name: "Hyatt House San Jose", adres: "10380 Perimeter Rd, Купертино, CA 85014", rating: 5, price: 90, commentAmount: 123, geoLat: 37.328976729914494, geoLong: -122.01304565107837, img: "Hyatt House San Jose"),
                    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hotelArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
        
    }
     
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let adresLabel = cell.viewWithTag(1001) as! UILabel
        let imageView = cell.viewWithTag(1002) as! UIImageView
        
        nameLabel.text = hotelArray[indexPath.row].name
        adresLabel.text = hotelArray[indexPath.row].adres
        
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: hotelArray[indexPath.row].img)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = storyboard?.instantiateViewController(identifier: "DetailView") as! ViewController
        
        //переход в экран деталей
        detailView.hotel = hotelArray[indexPath.row]
        navigationController?.show(detailView, sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
