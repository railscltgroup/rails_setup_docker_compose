# Step 1: Install Docker
Mac: https://www.docker.com/products/docker-desktop
Windows: https://www.docker.com/products/docker-desktop

# Step 2: git clone
https://github.com/railscltgroup/rails_setup_docker_compose.git

# Step 3: build a docker container that includes rails and runs, 'rails new myapp --database=postgresql' to create a new app
Mac: docker build --build-arg APP_NAME=myapp -f setup/createNewApp.Dockerfile -t web .

# Step 4: create a temp docker container
Mac: docker create --name temp-app web

# Step 5: Copy your new Rails app from your temp container to your desktop
Mac: docker cp temp-app:/docker-build/myapp ./

# Step 6: Remove the temp container
Mac: docker rm temp-app

# Step 7: Remove the setup image
Mac: docker image rm web

# Step 8: start new rails app using docker-compose
cd myapp
docker-compose up -d

# Step 9: setup database locally
docker-compose run --rm web rails db:create db:migrate

# Step 10: make sure app is working
visit http://localhost:3000/ in your browser

------- Turn Off App ----------
# Command to shut down your docker-compose container
docker-compose down

------- Turn App Back On ----------
# Command to shut down your docker-compose container
docker-compose up
visit http://localhost:3000/ in your browser

------- Delete App ----------
# You're done with your App. You want to remove it from your computer
docker-compose run --rm web rails db:drop
docker-compose down
docker image rm $(docker images | grep 'web')
docker image rm $(docker images | grep 'ruby')
docker image rm $(docker images | grep 'postgres')
delete myapp folder
