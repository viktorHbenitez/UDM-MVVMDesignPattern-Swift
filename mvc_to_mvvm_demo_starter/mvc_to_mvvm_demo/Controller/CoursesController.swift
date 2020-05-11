//
//  ViewController.swift
//  MVC
//
//  Created by Brian Voong on 6/30/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class CoursesController: UITableViewController {
  
  var courseViewModel : CourseViewModel?
  let cellId = "cellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavBar()
    setupTableView()
    fetchData()
  }
  
  fileprivate func fetchData() {
    Service.shared.fetchCourses { (courses, err) in
      if let err = err {
        print("Failed to fetch courses:", err)
        return
      }
      // important to past the objects to te viewmodel
//      self.arrCourseViewModels = courses?.map({return CourseViewModel(course: $0)}) ?? []
//      self.tableView.reloadData()
      
      if let arrCourse = courses{
        self.courseViewModel = CourseViewModel(arrCourse: arrCourse)
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return courseViewModel?.iNumberOfRow() ?? 0

  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                for: indexPath) as? CourseCell{
      if let courseModel = courseViewModel?.getCourseBussines(indexPath.row){
        cell.courseBussines = courseModel
        return cell
      }
    }
    return UITableViewCell()
  }
  
}

extension CoursesController{
  fileprivate func setupTableView() {
    tableView.register(CourseCell.self, forCellReuseIdentifier: cellId)
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    tableView.separatorColor = .mainTextBlue
    tableView.backgroundColor = UIColor.rgb(r: 12, g: 47, b: 57)
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 50
    tableView.tableFooterView = UIView()
  }
  
  fileprivate func setupNavBar() {
    navigationItem.title = "Courses"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .gray
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 50, g: 199, b: 242)
    navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
  }
  
}

class CustomNavigationController: UINavigationController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension UIColor {
  static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89)
  static let highlightColor = UIColor.rgb(r: 50, g: 199, b: 242)
  
  static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
  }
}
