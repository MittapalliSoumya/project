#######

Steps to run the project:

1) I created a project and have 3 files in the project. The file uses
   test-interview-question-master folder

2) Files description :
   a. docker-compose.yml has all the configurations for master, slaves, client and networks
   b. Dockerfile is copies the app, creates the working directory, adds
      the secret key from secret.yml file (provided in test-interview-master) and runs the bundle install.
   c. test.bash is used to test that environments are up and there is connectivity from master to slave and
      no connectivity from slave to slave
      
3) Steps to run and verify the output:

    a. Import project and Start docker 
    b. build the docker with below command. Note: this is a one time activity
       docker build -t rails:v1 .
    c. Once build is done run test.bash . If there is any permission issue please use below command:
       chmod 777 test.bash 
    
   