import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var degrees: Double = 0
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var isNight = false
    @Published var isLoading = false
    @Published var currentWeatherInfo: WeatherAllInfo?
    @Published var dailyWeatherInfo: WeatherAllInfo?

    var isFirstLocationUpdate = true

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()
        
        // 권한이 이미 부여된 경우 위치 요청
        if CLLocationManager.locationServicesEnabled() && manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways
        {
            isLoading = true
            manager.requestLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case.notDetermined:
               // 권한 결정 중
               break
           case.restricted,.denied:
               // 권한이 거부되었습니다.
               print("Location services disabled")
           case.authorizedAlways,.authorizedWhenInUse:
               // 권한이 부여되었습니다.
               manager.requestLocation()
           @unknown default:
               // 다른 상태
               break
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard isFirstLocationUpdate else { return }
            isFirstLocationUpdate = false
        
        guard let data = locations.first?.coordinate else { return }
        
        coordinate = data
        getCurrentWeather(lat: data.latitude, lon: data.longitude)
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError ::: ",error)
    }
    
    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() && manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways
        {
            isFirstLocationUpdate = true
            manager.requestLocation()
        }
    }
    
    func getCurrentWeather(
        lat: Double = Constants.baseLatitude,
        lon: Double = Constants.baseLongitude
    ) -> Void {
        isLoading = true
        
        NetworkManager.networkRequest.fetchCurrent(
            coordinate: Coordinate(
                latitude: lat,
                longitude: lon
            )
        ) { result in
            self.isLoading = false
            
            switch result {
            case .success(let data):
                self.currentWeatherInfo = data
                return
            case .failure(let error):
                return
            }
        }
    }
    
    func getDailyWeather(
        lat: Double = Constants.baseLatitude,
        lon: Double = Constants.baseLongitude
    ) -> Void {
        isLoading = true
        
        NetworkManager.networkRequest.fetchDailyForecast(
            coordinate: Coordinate(
                latitude: lat,
                longitude: lon
            )
        ) { result in
            self.isLoading = false
            
            switch result {
            case .success(let data):
                self.currentWeatherInfo = data
                return
            case .failure(let error):
                return
            }
        }
    }
}
