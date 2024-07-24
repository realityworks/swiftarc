
# Swift Architecture
## Template Project

This product is a developer template to make it easier in creating an app that is built on the SOLID principles of software architecture.

It does this by providing rules around where to build user interface logic, business logic and external integrations.

The standard application model runs on the following three layers.




## Project Layers

### Presentation

Consists of the Model and the View. In our representation the Model is an ObservableObject and Views are SwiftUI View.

There is also an alert system which listens to events within the app and presents them modally or non-modally.

### Domain Layer

Consists of a Global State structure that contains the state of all of the application. This is subdivided into specific context state for different parts of the app.

Additionally there are use UseCases which perform the business logic as seperate from any UI or service implementation. 

There is a stream of domain error events which indicate the outcome of events.

### Services Layer

The services layer provides an easy way to interface with external behaviour that is not specific to the apps business logic and user experience.



![Logo](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/th5xamgrr6se0x5ro4g6.png)
## Authors

- [@realityworks](https://www.github.com/realityworks)

