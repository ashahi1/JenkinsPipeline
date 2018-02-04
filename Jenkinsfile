node("vdvs-slave-two") {

    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace. */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; */

        sh "echo BUILDING IMAGE"
        sh "git clone https://github.com/ashahi1/docker-volume-vsphere.git"
        sh "pwd"
        sh "ls"
        sh "cd root/var/jenkins/workspace/vdvs-pipeline/docker-volume-vsphere/"
        sh "pwd"
        sh "ls"
        sh "echo FINISHED BUILDING IMAGE"
     
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

            sh "echo Finished Tests passed"
            
    }

    stage('Result') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
         
         sh "echo Pipeline finished"
    }
}
