//
//  HomeViewController_GSMController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-07-16.
//
//  API Network Class

import Foundation
import GooglePlaces

extension HomeViewController: GMSAutocompleteViewControllerDelegate {

      // Handle the user's selection.
      func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
          debugPrint("Place name: \(String(describing: place.name))")
          //debugPrint("Place ID: \(String(describing: place.placeID))")
          //debugPrint("Place attributions: \(String(describing: place.attributions))")

          savePlace(title: place.name ?? "Unknown Location", lat: place.coordinate.latitude, long: place.coordinate.longitude)
          collectionView.reloadData()
          dismiss(animated: true, completion: nil)
      }

      func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: Network Unavialable ", error.localizedDescription)
      }

      // User canceled the operation.
      func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
      }

      // Turn the network activity indicator on and off again.
      func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      }

      func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
      }
}
