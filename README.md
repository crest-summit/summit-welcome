# Summit Welcome

This project provides the "landing page" for Summit.

The intent of the project is that the static files are loaded into the ```/public``` directory.  These files are then loaded into a simple Nginx Docker container for easy distribution.


## Development

The project comes with a ```docker-compose.yml``` file to make development easy to get started.

```docker-compose up -d```

Once Docker has started up the application, you can reach the app at http://localhost:8080/.

The docker-compose stack mounts the ```public``` directory, so changes can be made to the source files and viewed immediately in the browser.