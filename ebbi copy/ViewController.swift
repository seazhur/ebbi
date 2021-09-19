//
//  ViewController.swift
//  ebbi
//
//  Created by Cesar Fuentes on 5/28/21.
//


import UIKit
import RealmSwift
import Charts


var MAX_ITEMS: Int {
    get { return UserDefaults.standard.integer(forKey: "MAX_ITEMS") }
    set { UserDefaults.standard.set(newValue, forKey: "MAX_ITEMS") }
}


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    // MARK: Views
    
    
    @IBOutlet weak var progressBar: CircularProgressBar!
    @IBOutlet weak var courseCollection: UICollectionView!
    @IBOutlet weak var weeklyBarChart: BarChartView!
    @IBOutlet weak var chartBackground: UIView!    
    
    
    // MARK: Properties
    
    
    private var data : Results<Course>!
    private let realm = try! Realm()
    let items = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    
    public let mainAccentColor = UIColor(red: 191.0/255.0, green: 218.0/255.0, blue: 237.0/255.0, alpha: 255.0/255.0)
    
    
    // UIColor(red: 138.0/255.0, green: 154.0/255.0, blue: 91.0/255.0, alpha: 255.0/255.0)

    
    
    
    // MARK: Initializers
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // Set Background Blur Effect
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = mainWallpaper.bounds
        view.insertSubview(blurredEffectView, at: 1)
        */
        
        //grayScreen.backgroundColor = UIColor(red: 243.0/255.0, green: 246.0/255.0, blue: 251.0/255.0, alpha: 100.0/255.0)
        self.view.backgroundColor = UIColor(red: 245.0/255.0, green: 247.0/255.0, blue: 251.0/255.0, alpha: 255.0/255.0)
        // rgba(245,247,251,255)
        
        // Initialize Global Variables Once
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore  {
            // myHour = 9
            // myMinute = 0
            MAX_ITEMS = 3
            // notificationGranted = false
            // lastChecked = Calendar.current.date(byAdding: DateComponents(year: -1), to: Date())! // one year from date of first opened
            // UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        // Update Data Array
        data = realm.objects(Course.self) // .sorted(byKeyPath: "nextReplaced", ascending: true)
        
        /*
        // Set Circular Progress Bar
        progressBar.labelSize = 40
        progressBar.setProgress(to: 0.75, withAnimation: true)
        */
        
        // Set Class Collection View
        // loadSampleCourses()
        courseCollection.backgroundColor = UIColor.clear
        
        /*
        // Set Bar Graph
        UIView.makeViewRound(view: chartBackground, color: mainAccentColor, radius: 5)
        let unitsSold = [13.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0]
        setChart(dataPoints: weekdays, values: unitsSold)
        */
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        // Set Progress Bar Background Color
        UIView.makeViewRound(view: progressBar, color: mainAccentColor, radius: 110)
        */
        
    }
    
    
    // MARK: Table
    
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get A Reference To Storyboard Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath as IndexPath) as! CourseCollectionViewCell
        let courseForCell = data[indexPath.row]
        cell.courseTitle.text = courseForCell.courseName
        cell.courseSubtitle.text = courseForCell.courseSubName
        cell.courseImage.image = UIImage(data: courseForCell.icon as Data)
        
        cell.courseImage.tintColor = UIColor.gray
        
        
        // Set Collection Cell Background Color
        let cellColor = UIColor.UIColorFromString(string: courseForCell.colorName)
        UIView.makeViewRound(view: cell, color: cellColor, radius: 5)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: New View Controller
        
        /*
         tableView.deselectRow(at: indexPath, animated: true)
         let item = data[indexPath.row]
         guard let vc = storyboard?.instantiateViewController(identifier: "view") as? DetailViewController else { return }
         vc.item = item
         // refresh the table when returning to view (when replacing or deleting)
         vc.replacementHandler = { [weak self] in self?.refresh() }
         vc.deletionHander =  { [weak self] in self?.refresh() }
         vc.title = item.name
         vc.navigationItem.largeTitleDisplayMode = .always
         navigationController?.pushViewController(vc, animated: true)
         */
        
    }
    
    
    // MARK: Bar Chart
    
    /*
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            
            // TODO: 2nd Arguement To Differences Array
            
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i],values[i]+1.0])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries)
        chartDataSet.colors = [UIColor.white]
        let chartData = BarChartData(dataSet: chartDataSet)
        weeklyBarChart.data = chartData
        weeklyBarChart.backgroundColor = UIColor.clear
        // table aesthetics
        weeklyBarChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:weekdays)
        weeklyBarChart.xAxis.labelTextColor = UIColor.white
        weeklyBarChart.xAxis.drawGridLinesEnabled = false // removes grid
        weeklyBarChart.xAxis.drawAxisLineEnabled = false // removes xaxis
        weeklyBarChart.rightAxis.enabled = false // removes right numbers and rightmost line
        weeklyBarChart.leftAxis.enabled = false // removes left numbers and leftmost line
        weeklyBarChart.drawBordersEnabled = false // thick box surrounding graph
        weeklyBarChart.legend.enabled = false // removes legend
        weeklyBarChart.xAxis.labelPosition = .bottom // moves labels to bottom
        weeklyBarChart.highlightFullBarEnabled = false
        weeklyBarChart.highlightPerTapEnabled = false
        weeklyBarChart.highlightPerDragEnabled = false
        weeklyBarChart.pinchZoomEnabled = false
        weeklyBarChart.doubleTapToZoomEnabled = false
        weeklyBarChart.xAxis.yOffset = -10
        weeklyBarChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBack)
    }
    
    */
    
    // MARK: Actions
    
    
    @IBAction func didTapAddButton(_ sender: Any) {
        
        print("Trying To Add")
        
        if (data.count >= MAX_ITEMS) {
            // TODO: Add Button To Update App
            // Too Many Items
            let defaultAction = UIAlertAction(title: "Okay", style: .cancel) { (action) in }
            let upgradeAction = UIAlertAction(title: "Upgrade", style: .default) { (action) in }
            let alert = UIAlertController(title: "Too Many Items", message: "Please delete older items or upgrade the app.", preferredStyle: .alert)
            alert.addAction(defaultAction)
            alert.addAction(upgradeAction)
            self.present(alert, animated: true) {}
        } else {

            let vc = storyboard?.instantiateViewController(identifier: "addView") as? AddViewController
            // vc!.modalPresentationStyle = .pageSheet
            vc!.addCompletionHandler = { [weak self] in self?.refresh() }
            present(vc!, animated: true)
            
            // navigationController?.pushViewController(vc!, animated: true)
            

            
        }
    }
    
    func refresh() {
        data = realm.objects(Course.self) // .sorted(byKeyPath: "nextReplaced", ascending: true)
        courseCollection.reloadData()
    }
    
    
}
