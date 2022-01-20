## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)

## General info
This project is an app for emergency alarms
	
## Technologies
Project is created with:
* Flutter: 2.8.1
* Dart: 2.15.1
	
## Setup
Once you are inside the project folder navigate to the app folder:
```
cd app
```
then run the command
```
flutter pub get
```
to install all the projects dependencies. The project has only been tested on an android emulator with api 29.

To run this project in its entirety you would need to also download the following github repos:
* [oop2proj_docker](https://github.com/Stektsnus/OOP2proj_docker)
* [oop2proj_webserver](https://github.com/Stektsnus/OOP2proj_webserver)

The set up files structure should be like this:
```bash
├── mydir
     ├── oop2proj_app
     ├── oop2proj_webserver
     └── oop2proj_docker
```
Make sure to install [docker](https://www.docker.com) and start your docker daemon. Then navigate inside the docker folder and run the command:
```
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d --build
```
once you have built the project you can run the command witout the --build flag like so:
```
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d
```
This will start your docker containers in which the webserver and the database are running.
