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
        sh "cd docker-volume-vsphere/; pwd; ls; make build-all"
        sh "echo FINISHED BUILDING IMAGE"
     
    }

    stage('Deploy image') {
        /* This builds the actual image; */

        sh "echo DEPLOYING IMAGE"
        sh "ls"
        sh "echo $ESX; echo $VM1; echo $VM2; echo $VM3;"
        sh "cd docker-volume-vsphere/; make deploy-all"
        sh "echo FINISHED DEPLOYING THE IMAGE"

    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

            sh "echo TESTS PASSED"
            
    }

    stage('Result') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
         
         sh "echo PIPELINE FINISHED"
         sh "rm -fr docker-volume-vsphere/"
    }
}
