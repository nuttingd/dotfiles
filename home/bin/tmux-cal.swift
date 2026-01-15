import EventKit
import Foundation

let store = EKEventStore()
let semaphore = DispatchSemaphore(value: 0)

// Calendar to monitor - passed as first argument, or default
let calendarName = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "Main Calendar"

store.requestFullAccessToEvents { granted, error in
    defer { semaphore.signal() }
    guard granted else { return }
    
    // Find the specific calendar
    let calendars = store.calendars(for: .event).filter { $0.title == calendarName }
    guard !calendars.isEmpty else { return }
    
    let now = Date()
    let thirtyMins = now.addingTimeInterval(30 * 60)
    
    let predicate = store.predicateForEvents(withStart: now.addingTimeInterval(-60 * 60), end: thirtyMins, calendars: calendars)
    let events = store.events(matching: predicate)
        .filter { !$0.isAllDay } // Filter out all-day events
        .sorted { $0.startDate < $1.startDate }
    
    for event in events {
        let startMins = Int(event.startDate.timeIntervalSince(now) / 60)
        let endMins = Int(event.endDate.timeIntervalSince(now) / 60)
        print("\(event.title ?? "")|\(startMins)|\(endMins)")
    }
}

semaphore.wait()
