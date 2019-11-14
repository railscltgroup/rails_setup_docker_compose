# Create a Rails App Using Docker
The Rails Charlotte Group previously offered a Rails class to our community.

In creating the class, we could not find any up-to-date, solid installation process for creating a new Rails App.  

So, we’ve create this Rails Setup repo to help students get started with their first Rails app.

This setup uses Docker and docker-compose to build and maintain a Rails application.

### Step 1: Prerequisites
The following software needs to be installed on your computer before you can start
* Docker: https://www.docker.com/products/docker-desktop
* Git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
* Visual Studio Code: https://code.visualstudio.com
  * We recommend Visual Studio Code because it comes with a built-in terminal.  You don’t have to use Visual Studio Code.  You are welcome to use any coding editor/terminal  you are comfortable with.  Just keep in mind, these instructions will be using Visual Studio Code.

### Step 2: Clone Setup Files
You will need to create a new folder on your computer.  You can place that folder in any location you want on your computer.  You can also name the folder anything you want.  I am going to name the folder `LearnRails`

Once you have created the empty folder, open the folder in Visual Studio Code.

In Visual Studio Code, click on `Terminal` and `New Terminal`.

In your newly opened terminal, run
```
git clone https://github.com/railscltgroup/rails_setup_docker_compose.git
```
Once you run this command, a new fold should appear called `rails_setup_docker_compose` This folder will have all the Rails and Docker files needed to create your first app.

run
```
cd rails_setup_docker_compose
```
To move your terminal into the new folder

### Step 3: Build a new Rails App in Docker
First, make sure you have Docker running on your computer.   You can type `docker info` in your terminal to see that it is working.

Once Docker is running, run the following command in your terminal
```
docker build --build-arg APP_NAME=myapp -f setup/createNewApp.Dockerfile -t web .
```
This command will use the file `rails_setup_docker_compose/setup/createNewApp.Dockerfile` to install Rails software and build a new Rails app named `myapp`.  It may take awhile to install and build.

### Step 4: Create a temp docker container
run
```
docker create --name temp-app web
```
To create a temporary container in docker.

### Step 5: Copy your new Rails app to your computer
run
```
docker cp temp-app:/docker-build/myapp ./
```
to copy the Rails application from your temporary docker container, to your computer.

A new folder should appear in your `rails_setup_docker_compose`.  That new folder is your Rails App.  You can choose to keep is in the `rails_setup_docker_compose`, or you can move it to another location on your computer.

### Step 6: Remove the temp container
run
```
docker rm temp-app
```
To delete the temporary container from docker

### Step 7: Remove the setup image
run
```
docker image rm web
```
To delete the setup image from docker.

### Step 8: Start app using docker-compose
You have created a new Rails App!

This means you are done with the setup folder.  You can keep it or remove it from your computer.  It’s your choice!

Next, you want to use Visual Studio Code to open the `myapp` folder you just created

You’ll also need to click on `Terminal` and `New Terminal` to open a terminal in your app.

Once you are located in your new Rails app, run
```
docker-compose build
```
To build and start-up your new app.  This may take awhile to finish.

### Step 9: Setup database
You app is running, but you have not created a database.
run
```
docker-compose run --rm web rails db:create db:migrate
```
to create a database, connected to your app

### Step 10: Checkout your app
Visit http://localhost:3000/ in your browser.  

If your app is working, you should see `Yay! You're on Rails!` on the webpage.

Congratulations! You’ve made a Rails application!

Checkout (https://railsclt.com/learn) for next steps and additional tutorials.

-------------

## Turn off your Rails App
Docker will keep running in the background on your computer.  If you don’t turn it off, it may drain your battery.  

When you are done working on your app, make sure to run
```
docker-compose down
```
This will not delete your docker images, but it will shut down a lot of running processes.

When you are ready to turn it back on, run
```
docker-compose up
```

-----
## Delete your app
If you are done working on the app and you want to delete all docker images from your computer, run the following commands in your terminal

#### Delete your database
run
```
docker-compose run --rm web rails db:drop
```

#### Turn off docker app processes
run
```
docker-compose down
```

#### Delete all docker images that contain the name “web”
run
```
docker image rm $(docker images | grep 'web')
```

#### Delete all docker images that contain the name “ruby”
run
```
docker image rm $(docker images | grep 'ruby')
```

#### Delete all docker images that contain the name “postgres”
run
```
docker image rm $(docker images | grep 'postgres')
```

### Delete myapp folder from your computer
