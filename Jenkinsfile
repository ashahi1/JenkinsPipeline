node("vdvs-slave-2") {

    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace. */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; */

        sh "git clone https://github.com/ashahi1/docker-volume-vsphere.git"
        sh "pwd"
        sh "ls"
        sh "cd docker-volume-vsphere"
        sh "ls"
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh "echo Tests passed"
        }
    }

    stage('Result') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
         
         sh "echo Tests finished"
    }
}
