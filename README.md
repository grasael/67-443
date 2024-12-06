# Welcome to our app: Rently
This is an iOS mobile application written in Swift as part of our project for course 67-443, affiliated with Carnegie Mellon University.

**Contributors:**

Sara Riyad
Grace Liao
Tishyaa Chaudry
Abby Chen

#Overview
Rently is designed for users who value sustainable fashion and wish to participate in the circular economy. It facilitates clothing rentals within college campuses, enabling users to share items conveniently and securely. By renting instead of buying, users can reduce their contribution to fast fashion’s environmental impact, including:
* 10% of global carbon dioxide emissions.
* 20% of global wastewater production.
* Excessive textile waste and microplastic pollution.
  
Rently fosters community connections and makes eco-friendly fashion accessible to students, providing a sustainable alternative to conventional shopping. Rently is tailored for college students by college students. 

#Data
Rently manages the following data categories:
1. Listings: Information about available clothing items, including details, photos, and rental terms.
2. Rentals: Records of items rented, duration, and associated users.
3. Reviews: Feedback on users and items to foster accountability.
4. Users: Profiles tied to school-verified email accounts for authenticity and safety.

All data is stored in Firestore for real-time synchronization.



# Technical Implementation
**Frameworks & Tools Used:**
*Swift: The primary programming language for the application.
*Firebase: For user authentication (Firebase Authentication), data storage (Firestore), and real-time data synchronization.
*CoreData: Used for local caching of data in case of offline mode.
*UIKit: For building user interfaces.
*SwiftUI: Used in some areas for creating declarative user interfaces.
*XCTest: Used for unit testing the application.


**Firebase Integration:**
*Firebase Authentication: Handles user sign-up and user session management. All user authentication data is securely stored in Firebase Authentication.

*Firestore: All app data (listings, rentals, reviews) is stored and synced in real-time using Firestore. This ensures that all users have the latest information immediately.

*Firebase Storage: For storing and retrieving user-uploaded images and other media files associated with listings.

**Core Features:**
*Listings Browsing: Users can browse available rental listings stored in Firestore.
*Rental Management: Users can rent items from others and place their items for rent throughout their general college community.
*Reviews: Users can leave reviews for items they rented. Reviews are stored in Firestore and updated in real-time.
*Search Functionality: Users can search listings by various criteria, with search data also pulled from Firestore.


#Testing:
We performed unit testing on the code we've implemented, including:

Models: Listing, Rental, Review, User models.
ViewModels: Testing logic behind the app's data presentation.
Views: While some basic UI testing was done, we did not test the actual views in depth, such as ListingView, because they are simple representations of the data already covered.
Test coverage currently stands at 23%, which primarily reflects coverage for our core models and view models. 


#Design Decisions

Why School Emails?
Based on user interviews, we chose to require school email logins to:

*Connect users to their college community.
*Maintain boundaries for safety and accountability.
*Reduce concerns by limiting email communications to rental and listing confirmations.
*Notifications to set pickup dates in your calendar
*Emails are sent for listing confirmations and rental updates, but unnecessary messages are avoided to respect user inboxes.



#Additional Notes
Please make sure your device is logged in on Apple's email app with your school email. The email prompt will not work otherwise. This feature cannot be tested on the simulator. 

For the best experience, we recommend ensuring a stable internet connection when creating or renting listings, as image uploads and notifications may require network access.

Rently is a step toward a greener future, making sustainable fashion accessible and fostering community collaboration within college campuses. Thank you for exploring our app!
