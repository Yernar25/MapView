//
//  ViewControllerRoute.swift
//  MapView
//
//  Created by Yernar Dyussenbekov on 13.11.2024.
//

import UIKit
import MapKit

class ViewControllerRoute: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapViewRoute: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    var hotelAnotation = MKPointAnnotation()
    var isRouted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewRoute.delegate = self
      
        // Добавляем метку на карту
        mapViewRoute.addAnnotation(hotelAnotation)
        
        //Запрашиваем разрешение на использование местоположения пользователя
        locationManager.requestWhenInUseAuthorization()
        
         //delegate нужен для функции didUpdateLocations, которая вызывается при обновлении местоположения (для этого прописали CLLocationManagerDelegate выше)
        locationManager.delegate = self
        
         //Запускаем слежку за пользователем
        locationManager.startUpdatingLocation()
            
    } //verride func viewDidLoad()
    
    // Вызывается каждый раз при изменении местоположения нашего пользователя
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLocation = locations[0]
        
        if !isRouted {
            // Дельта - насколько отдалиться от координат пользователя по долготе и широте
            let latDelta:CLLocationDegrees = 0.01
            let longDelta:CLLocationDegrees = 0.01

            // Создаем область шириной и высотой по дельте
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            
            // Создаем регион на карте с моими координатоми в центре
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
            
            // Приближаем карту с анимацией в данный регион
            mapViewRoute.setRegion(region, animated: true)
      
            // Получаем координаты метки Hotel
            let location:CLLocation = CLLocation(latitude: (hotelAnotation.coordinate.latitude), longitude: (hotelAnotation.coordinate.longitude))
            
            // Считаем растояние до метки от нашего пользователя
            let meters:CLLocationDistance = location.distance(from: userLocation)
            distanceLabel.text = String(format: "Distance: %.2f m", meters)
            
            // Routing - построение маршрута
            // 1 Координаты начальной точки А и точки B
            let sourceLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
            let destinationLocation = CLLocationCoordinate2D(latitude: (hotelAnotation.coordinate.latitude), longitude: (hotelAnotation.coordinate.longitude))
            
            // 2 упаковка в Placemark
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            
            // 3 упаковка в MapItem
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            // 4 Запрос на построение маршрута
            let directionRequest = MKDirections.Request()
            // указываем точку А, то есть нашего пользователя
            directionRequest.source = sourceMapItem
            // указываем точку B, то есть метку на карте
            directionRequest.destination = destinationMapItem
            // выбираем на чем будем ехать - на машине
            directionRequest.transportType = .automobile
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            // 5 Запускаем просчет маршрута
            directions.calculate {
                (response, error) -> Void in
                
                // Если будет ошибка с маршрутом
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    return
                }
                // Берем первый машрут
                let route = response.routes[0]
                // Удалить все существующие маршруты
                //self.mapViewRoute.removeOverlays(self.mapViewRoute.overlays)
                // Рисуем на карте линию маршрута (polyline)
                self.mapViewRoute.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
                
                // Приближаем карту с анимацией в регион всего маршрута
                let rect = route.polyline.boundingMapRect
                self.mapViewRoute.setRegion(MKCoordinateRegion(rect), animated: true)
            }
            isRouted = true
        }//if
        
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // Настраиваем линию
        let renderer = MKPolylineRenderer(overlay: overlay)
        // Цвет красный
        renderer.strokeColor = UIColor.red
        // Ширина линии
        renderer.lineWidth = 3.0
        return renderer
    }
     


}
