This is a simple repo to test out software and workflows that will be used by the [MGI][0] for the [CCDG][4] project.

# Phase 0: Getting started with Docker

See the following links:

1.  [installing docker on macOS][1]
2.  [basic docker usage][2]
3.  [keeping your docker installation up to date on macOS][3]

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
* CCDG related software is currently located at: https://bitbucket.org/idas/ccdg-apt-repo
* you may need to wait a few moments for docker hub to accept and make your image available to the public after its been successfully pushed


# Phase 2: On a MGI LSF client
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

## Notes

When running Docker on an MGI LSF client, you're really invoking `docker run` via a shell wrapper.  The shell wrapper will:

1. Preserve the MGI bash environment you had before you invoked `bsub`
2. Shares NFS volumes (includes `/gscuser`; implies that your `/gscuser/<id>/.bashrc` profile gets invoked)
3. Adds a `-v /var/lib/sshd:/var/lib/sshd` to the docker run command.  This allows for a shared pipe for user id stuff.

[0]: http://genome.wustl.edu
[1]: https://mixablehodgepodge.blogspot.com/2016/10/docker-install-docker-on-apples-macos.html
[2]: https://mixablehodgepodge.blogspot.com/2016/10/docker-basic-usage.html
[3]: https://mixablehodgepodge.blogspot.com/2016/10/docker-updating-docker-installation-on.html
[4]: https://www.genome.gov/27563570/
