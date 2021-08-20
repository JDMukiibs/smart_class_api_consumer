# Smart Class

The Smart Class application was a protoype project my supervisor tasked me with building as a possible solution to helping teachers during the pandemic have an alternative method to tracking student engagement during live synchronous online classes. 

# Detailed information

A Flutter app that will send images to an API, the API will classify the level of engagement of the student and save the result to a small Database.
Later on, the API will provide the app with an endpoint to have a metric report of the engagement throughout the class.
The API codes that the app communicates with can be found in this other [repository](https://github.com/KimRaicho/smartClassAPI) which was used to store the ML model code that generated the model that classified sent images. @KimRaicho developed and trained the ML model that was used for classification of images.
The repo also houses the FLASK API and server code within the server folder which I contributed to by writing the Flask API code and designing the simple database we were going to use.

Moving back to the FE, before building the application I made some designs using [Figma](https://www.figma.com/file/pB7TcjGzSjkruTI1cV6GVj/SmartClass-API-Consumer?node-id=13%3A576). 

## Running the app

If you have Android Studio, it is simply a matter of cloning the project and clicking play. In order to fully be able to test the uploading of images and creation of a report, you'll need to run the server whose code can be found in the aforementioned repository. In the readME of the repo, you'll also see that there is a link to the final model used.

### Demo

The demo file was 3mb too large so here is a link to it instead. [Smart Class Demo](https://drive.google.com/file/d/1DSaNXvJgBrodfsdpAti9Ay2aYyJQYZxa/view?usp=sharing)
