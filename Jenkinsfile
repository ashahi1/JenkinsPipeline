node("vdvs-slave-two") {

    def app
    
    def DIRECTORY = 'docker-volume-vsphere'
   
    dir('docker-volume-vsphere') {
       sh "echo Trying again to delete ${DIRECTORY} "
       deleteDir()
    }

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build Linux plugin') {
        /* This builds the actual image; */

        sh '''if [ -d "\\${DIRECTORY}" ]; then
           # Control will enter here if ${DIRECTORY} exists.
           sh "echo \\${DIRECTORY} exists so DELETING it."
           sh "rm -fr \\${DIRECTORY}/"
        fi'''

        sh '''sh "echo BUILDING IMAGE NEW"
        sh "git clone https://github.com/ashahi1/docker-volume-vsphere.git"
        sh "cd \\${DIRECTORY}/; make build-all" ''' 
     
    }

    stage('Deploy') {
        /* This builds the actual image; */

       sh "echo DEPLOYING IMAGE"
       sh "ls" 
       sh "echo ESX = $ESX; echo VM-1=$VM1; echo VM-2=$VM2; echo VM-3=$VM3;" 
       sh "cd \${DIRECTORY}/; make deploy-all" 
       sh "echo FINISHED DEPLOYING THE IMAGE"
      

    }
    
    stage('Executing End-to-End Tests') {
     
         sh "echo STARTING E2E TESTS" 
         sh "cd \${DIRECTORY}/; make test-e2e || true"
         currentBuild.result = 'SUCCESS'

     }       

    stage('Build Windows plugin') {
        /* This builds the actual image; */

        sh "echo BUILDING Windows IMAGE"
        sh "make build-windows-plugin"
        sh "echo FINISHED BUILDING IMAGE"

    }

    stage('Deploy Windows plugin') {
        /* This builds the actual image; */

        sh "echo DEPLOYING IMAGE"
        sh "ls"
        sh "echo Windows-VM = $WIN_VM1"
        sh "cd \${DIRECTORY}/; make deploy-windows-plugin"
        sh "echo FINISHED DEPLOYING THE IMAGE"

    }

   stage('Executing Windows Plugin Tests') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

            sh "echo STARTING WINDOWS TESTS"
            def result = sh "cd docker-volume-vsphere/; make test-e2e-windows"
            if (result != 0) {
            echo '[FAILURE] Failed to build'
            currentBuild.result = 'FAILURE'
            }
    }

    post {
         always {
         
         sh "echo CLEANUP"
         sh "cd \${DIRECTORY}/; make clean-all; rm -fr \${DIRECTORY}/"
         sh "echo PIPELINE FINISHED"
        }
    }
}
