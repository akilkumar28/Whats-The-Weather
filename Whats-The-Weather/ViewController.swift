//
//  ViewController.swift
//  Whats-The-Weather
//
//  Created by AKIL KUMAR THOTA on 6/4/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtFld: UITextField!
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func submitPrssd(_ sender: Any) {
        
        if !((txtFld.text?.isEmpty)!) {
            
            if let name = txtFld.text?.replacingOccurrences(of: " ", with: "-") {
                
                
                if let url = URL(string: "http://www.weather-forecast.com/locations/"+name+"/forecasts/latest") {
                    
                    let request = URLRequest(url: url)
                    
                    var message = ""
                    
                    let task = URLSession.shared.dataTask(with: request) { (Data, URLResponse, Error) in
                        
                        if Error != nil {
                            print("Error Occured")
                        } else {
                            
                            
                            if let unrappedData = Data {
                                
                                let answer = NSString(data: unrappedData, encoding: String.Encoding.utf8.rawValue)
                                var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                                
                                if let contentArray = answer?.components(separatedBy: stringSeparator) {
                                    
                                    
                                    if contentArray.count > 1 {
                                        
                                        stringSeparator = "</span>"
                                        
                                        let newArray = contentArray[1].components(separatedBy: stringSeparator)
                                        
                                        if newArray.count > 1 {
                                            
                                            
                                            message = newArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                            
                                            
                                        }
                                    }
                                }
                                
                                
                            }
                        }
                        if message == "" {
                            message = "The weather there couldn't be found. Please try again."
                        }
                        
                        DispatchQueue.main.async {
                            
                            self.resultsLabel.text = message
                        }
                        
                    }
                    task.resume()
                    
                    
                    
                } else {
                    resultsLabel.text = "The weather there couldn't be found. Please try again."
                }
            } else {
                resultsLabel.text = "Please enter the name of the city properly."
            }
        } else {
            resultsLabel.text = "Please Enter Some name of the city."
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

