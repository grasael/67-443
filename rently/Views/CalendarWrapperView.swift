//
//  CalendarWrapperView.swift
//  rently
//
//  Created by Abby Chen on 11/7/24.
//

import SwiftUI
import UIKit

struct CalendarWrapperView: UIViewRepresentable {
  @Binding var selectedDates: Set<Date>  // Store selected dates
    
  func makeUIView(context: Context) -> UICalendarView {
    let calendarView = UICalendarView()
    
    // multi-date selection
    let multiDateSelection = UICalendarSelectionMultiDate(delegate: context.coordinator)
    calendarView.selectionBehavior = multiDateSelection
    
    return calendarView
  }
    
  func updateUIView(_ uiView: UICalendarView, context: Context) {
  // update selected dates in the calendar view
    guard let multiDateSelection = uiView.selectionBehavior as? UICalendarSelectionMultiDate else { return }
        
    // clear selections and set updated selected dates
    multiDateSelection.selectedDates = selectedDates.map { Calendar.current.dateComponents([.year, .month, .day], from: $0) }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, UICalendarSelectionMultiDateDelegate {
    var parent: CalendarWrapperView
        
    init(_ parent: CalendarWrapperView) {
      self.parent = parent
    }
        
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents?) {
      guard let dateComponents = dateComponents,
            let date = Calendar.current.date(from: dateComponents) else { return }
            
      // add selected date to selectedDates
      parent.selectedDates.insert(date)
    }
        
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents?) {
      guard let dateComponents = dateComponents,
            let date = Calendar.current.date(from: dateComponents) else { return }
            
      // remove selected date from selectedDates
      parent.selectedDates.remove(date)
    }
  }
}
