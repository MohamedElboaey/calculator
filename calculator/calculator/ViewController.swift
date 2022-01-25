//
//  ViewController.swift
//  calculator
//
//  Created by Mohamed Elboraey on 21/01/2022.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var resultLB: UILabel!
    @IBOutlet weak var numTF: UITextField!
    @IBOutlet weak var plusBTN: UIButton!
    @IBOutlet weak var subBTN: UIButton!
    @IBOutlet weak var mutlBTN: UIButton!
    @IBOutlet weak var divBTN: UIButton!
    @IBOutlet weak var equalBTN: UIButton!
    var oberation = ""
    var undoArray : [String] = []
    var redoArray : [String] = []
    var Results = [String]()
    var RedouResults = [String]()
    var instialValue = 0.0
    var result = 0.0
    @IBOutlet weak var EgpAmount: UITextField!
    @IBOutlet weak var UsdAmount: UILabel!
    var CurrencyWithUsd = "1"

    @IBOutlet weak var collectioinView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        numTF.delegate = self
        collectioinView.delegate = self
        collectioinView.dataSource = self
        collectioinView.register(UINib (nibName: "operatorsCell", bundle: nil), forCellWithReuseIdentifier: "operatorsCell")
      plusBTN.layer.borderWidth = 1
       plusBTN.layer.borderColor = UIColor.white.cgColor
        subBTN.layer.borderWidth = 1
        subBTN.layer.borderColor = UIColor.white.cgColor
        mutlBTN.layer.borderWidth = 1
        mutlBTN.layer.borderColor = UIColor.white.cgColor
        divBTN.layer.borderWidth = 1
        divBTN.layer.borderColor = UIColor.white.cgColor
        equalBTN.layer.borderWidth = 1
        equalBTN.layer.borderColor = UIColor.white.cgColor
        
        getCurreny()
    }
    
    func getCurreny(){
        var request = URLRequest(url: URL(string: "https://api.fastforex.io/fetch-all?api_key=8e16ddefc9-6a5ac0eae0-r69mr0")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                var Model = json["results"] as! NSDictionary
                self.CurrencyWithUsd = "\((Model["EGP"] as? Double) ?? 0.0)"

            } catch {
                print("error")
            }
        })

        task.resume()
    }
    
    
    @IBAction func undoBTN(_ sender: UIButton) {
        if undoArray.count > 0 {
            self.redoArray.append(undoArray[undoArray.count - 1])
            RedouResults.append(Results[Results.count - 1])
            self.resultLB.text = Results[Results.count - 1]
            instialValue = Double(self.resultLB.text ?? "0") ?? 0.0
            Results.removeLast()
            undoArray.removeLast()
           
        }else {
            self.resultLB.text = "0"
            instialValue = 0
        }
        collectioinView.reloadData()
        equalBTN.layer.borderColor = UIColor.white.cgColor
    }
    @IBAction func plusBTN(_ sender: UIButton) {
        oberation = "+"
        if plusBTN.isHighlighted == true {
            plusBTN.layer.borderColor = UIColor.black.cgColor
            subBTN.layer.borderColor = UIColor.white.cgColor
            mutlBTN.layer.borderColor = UIColor.white.cgColor
            divBTN.layer.borderColor = UIColor.white.cgColor
            equalBTN.layer.borderColor = UIColor.white.cgColor
            
        }
        
    }
    @IBAction func subBTN(_ sender: UIButton) {
        oberation = "-"
        if subBTN.isHighlighted == true {
            plusBTN.layer.borderColor = UIColor.white.cgColor
            subBTN.layer.borderColor = UIColor.black.cgColor
            mutlBTN.layer.borderColor = UIColor.white.cgColor
            divBTN.layer.borderColor = UIColor.white.cgColor
            equalBTN.layer.borderColor = UIColor.white.cgColor
        }
        
    }
    @IBAction func mutlBTN(_ sender: UIButton) {
        oberation = "*"
        if mutlBTN.isHighlighted == true {
            plusBTN.layer.borderColor = UIColor.white.cgColor
            subBTN.layer.borderColor = UIColor.white.cgColor
            mutlBTN.layer.borderColor = UIColor.black.cgColor
            divBTN.layer.borderColor = UIColor.white.cgColor
            equalBTN.layer.borderColor = UIColor.white.cgColor
        }
       
    }
    @IBAction func divBTN(_ sender: UIButton) {
        oberation = "/"
        if divBTN.isHighlighted == true {
            plusBTN.layer.borderColor = UIColor.white.cgColor
            subBTN.layer.borderColor = UIColor.white.cgColor
            mutlBTN.layer.borderColor = UIColor.white.cgColor
            divBTN.layer.borderColor = UIColor.black.cgColor
            equalBTN.layer.borderColor = UIColor.white.cgColor
        }
       
    }
    @IBAction func equalBTN(_ sender: UIButton) {
        if equalBTN.isHighlighted == true {
            equalBTN.layer.borderColor = UIColor.black.cgColor
            plusBTN.layer.borderColor = UIColor.white.cgColor
            subBTN.layer.borderColor = UIColor.white.cgColor
            mutlBTN.layer.borderColor = UIColor.white.cgColor
            divBTN.layer.borderColor = UIColor.white.cgColor
        
        if !(numTF.text?.isEmpty ?? false){
            
            if oberation == "+" {
                instialValue = instialValue + (Double(numTF.text ?? "0") ?? 0.0)
                undoArray.append("\(oberation)\(numTF.text ?? "")")
            }else if oberation == "-" {
                instialValue = instialValue - (Double(numTF.text ?? "0") ?? 0.0)
                undoArray.append("\(oberation)\(numTF.text ?? "")")
            }else if oberation == "/" {
                instialValue = instialValue / (Double(numTF.text ?? "0") ?? 0.0)
                undoArray.append("\(oberation)\(numTF.text ?? "")")
            }else if oberation == "*" {
                instialValue = instialValue * (Double(numTF.text ?? "0") ?? 0.0)
                undoArray.append("\(oberation)\(numTF.text ?? "")")
            }
            
            Results.append(resultLB.text ?? "")
            collectioinView.reloadData()
            
            resultLB.text = "\(instialValue)"
            numTF.text = ""
            oberation = ""
            
        }
       
        }
        EgpAmount.text = (resultLB.text ?? "")
 
    }
    @IBAction func redoBTN(_ sender: UIButton) {
       
        if redoArray.count > 0 {
            self.undoArray.append(redoArray[redoArray.count - 1])
            Results.append(RedouResults[RedouResults.count - 1])
            self.resultLB.text = Results[Results.count - 1]
            instialValue = Double(self.resultLB.text ?? "0") ?? 0.0
            RedouResults.removeLast()
            redoArray.removeLast()
            collectioinView.reloadData()
            equalBTN.layer.borderColor = UIColor.white.cgColor
           
        }
       
        
    }
    @IBAction func convertBTN(_ sender: UIButton) {
        UsdAmount.text = "\((Double(EgpAmount.text ?? "") ?? 0.0)/(Double(CurrencyWithUsd) ?? 0.0))" + " USD"
        equalBTN.layer.borderColor = UIColor.white.cgColor
    }
    


}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return undoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "operatorsCell", for: indexPath) as! operatorsCell
        print(undoArray)
        cell.operationLB.text = undoArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView.numberOfItems(inSection: section) == 1 {

             let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.frame.width - flowLayout.itemSize.width + 75)

        }

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    }
    
}
