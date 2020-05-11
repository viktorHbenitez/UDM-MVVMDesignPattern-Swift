//
//  CourseViewModel.swift
//  mvc_to_mvvm_demo
//
//  Created by Brian Voong on 7/3/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import Foundation
import UIKit


// Add model bussines and element of the UIView (tableview)
struct CourseViewModel {
  let arrCourse : [Course]
  
  var iNumberOfSection : Int{
    return 1
  }
  
  func iNumberOfRow() -> Int{
    return arrCourse.count
  }
  
  func getCourseBussines(_ index : Int) -> CourseBussinesViewModel{
    return CourseBussinesViewModel(arrCourse[index])
  }
  
  
  
//    let name: String
//    let detailTextString: String
//    let accessoryType: UITableViewCellAccessoryType
//
//    // Dependency Injection (DI)
//    init(course: Course) {
//        self.name = course.name
//
//        if course.number_of_lessons > 35 {
//            detailTextString = "Lessons 30+ Check it Out!"
//            accessoryType = .detailDisclosureButton
//        }
//        else {
//            detailTextString = "Lessons: \(course.number_of_lessons)"
//            accessoryType = .none
//        }
//    }
  
  
}

// modifiy the model to show on the view  (desciption, title, subtitle)
struct CourseBussinesViewModel {
  private let iMaxlession : Int = 35
  private let course      : Course
  public var enumStyle    : enumAccesory = .isOff
  
  enum enumAccesory {
    case isOn
    case isOff
    
    // get
    var currentValue : Bool {
      switch self {
      case .isOn:
        return true
      case .isOff:
        return false
      }
    }
    
    var accesory : UITableViewCellAccessoryType{
      switch self {
      case .isOn:
        return .detailDisclosureButton
      case .isOff:
        return .none
      }
    }
  }
  
  init(_ course: Course) {
    self.course = course
    setAccesory()
  }
}
extension CourseBussinesViewModel{
  
  
  // Custom description of the bussines model
  var strNameCustom: String{
    return self.course.name + " iOS"
  }
  
  var strNumberooLessions : String{
    return "\(self.course.number_of_lessons)" + " iOS"
  }
  
  var strDetailTex : String{
    if self.course.number_of_lessons > iMaxlession{
      return "Lessons 30+ Check it Out!"
    }
    else{
      return "Lessons: \(course.number_of_lessons)"
    }
  }
  
  
  mutating func setAccesory(){
    if self.course.number_of_lessons > iMaxlession{
      self.enumStyle = enumAccesory.isOn
    }
    else{
      self.enumStyle = enumAccesory.isOff
    }
  }
  
}


/*
 JSON PARAMETERS
 "name"
 "link"
 "imageUrl"
 "number_of_lessons"
 */
