# Phase 1: On macOS

## Workflow

0. `git clone https://github.com/indraniel/test-ccdg-picard-docker-image`
1. `cd test-ccdg-picard-docker-image`
2. `docker build -t ccdg-picard-test:v1 . `
3. `docker images`
    
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    ccdg-picard-test    v1                  4b08fd89fe5e        2 minutes ago       879.5 MB
    ubuntu              14.04               1e0c3dd64ccd        12 days ago         187.9 MB
    
4. `docker tag 4b08fd89fe5e indraniel/ccdg-picard-test:v1`
5. `docker images`
    
    REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
    ccdg-picard-test             v1                  4b08fd89fe5e        4 minutes ago       879.5 MB
    indraniel/ccdg-picard-test   v1                  4b08fd89fe5e        4 minutes ago       879.5 MB
    ubuntu                       14.04               1e0c3dd64ccd        12 days ago         187.9 MB
    
6. `docker login`
7. `docker push indraniel/ccdg-picard-test`

## Notes

* Ensure that you have included the `libnss-sss` package; otherwise, you won't be able to properly access LDAP and the networked file system at the MGI.
* CCDG related software is currently located at: //bitbucket.org/idas/ccdg-apt-repo
* you may need to wait a few moments for docker hub to accept and make your image available to the public after its been successfully pushed


# Phase 2: On a MGI workstation

## Workflow 

0. `git clone https://github.com/indraniel/test-ccdg-picard-docker-image`
1. `cd test-ccdg-picard-docker-image`
2. `bsub -Is -q research-hpc -a 'docker(indraniel/ccdg-picard-test:v1)' /bin/bash`

### Try out picard

3. `/opt/ccdg/jdk-8u111/bin/java -jar /opt/ccdg/picard-2.4.1/picard.jar`

### Try out cowsay

4. `/usr/games/cowsay "whoo hoo!"`

### Try out a script in this git repo

5. `bash -x test.sh`