//
//  ViewController.swift
//  MapView
//
//  Created by Yernar Dyussenbekov on 13.11.2024.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var adresLabel: UILabel!
    
    var hotelAnotation = MKPointAnnotation()
    var hotel = Hotel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 10
        mapView.layer.cornerRadius = 10
        
        ratingImageView.layer.cornerRadius = 10
        ratingImageView.layer.borderWidth = 2
        
        imageView.image = UIImage(named: hotel.img)
        nameLabel.text = hotel.name

        ratingLabel.text = String("\(hotel.rating)  \(hotel.commentAmount) comments")
        priceLabel.text = String("Price:\(hotel.price)$")
        adresLabel.text = hotel.adres
        
        // ______________ Метка на карте ______________
        // координаты для метки на карте
        // Создаем координта передавая долготу и широту
        let hotelLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(hotel.geoLat, hotel.geoLong)
        
        // Создаем метку на карте
        hotelAnotation = MKPointAnnotation()
        
        // Задаем коортинаты метке
        hotelAnotation.coordinate = hotelLocation
        // Задаем название метке
        hotelAnotation.title = hotel.name
        
        // Добавляем метку на карту
        mapView.addAnnotation(hotelAnotation)
        
        // Дельта - насколько отдалиться от координат пользователя по долготе и широте
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01

        // Создаем область шириной и высотой по дельте
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        // Создаем регион на карте с моими координатоми в центре
        let region = MKCoordinateRegion(center: hotelAnotation.coordinate, span: span)
        
        // Приближаем карту с анимацией в данный регион
        mapView.setRegion(region, animated: true)
    }

    
    @IBAction func openRouteView(_ sender: Any) {
        let routeView = storyboard?.instantiateViewController(identifier: "RouteView") as! ViewControllerRoute
        //переход в экран маршрута с передачей метки
        routeView.hotelAnotation = hotelAnotation
        navigationController?.show(routeView, sender: self)
    }
    
    
}

