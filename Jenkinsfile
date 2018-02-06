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

        sh "echo BUILDING IMAGE NEW"
        sh "git clone https://github.com/ashahi1/docker-volume-vsphere.git"
        sh "cd \\${DIRECTORY}/; make build-all" 
     
    }

    stage('Executing Windows Plugin Tests') {
        try{        
            sh "echo STARTING WINDOWS TESTS"
            def result = sh "cd docker-volume-vsphere/; make test-e2e-windows"
         } catch (err){
           failTheBuild("Build failed")
       }
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
       try{   
         sh "echo STARTING E2E TESTS" 
         sh "cd \${DIRECTORY}/; make test-e2e"
       } catch (err){
           failTheBuild("Build failed")
       }
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
        try{        
            sh "echo STARTING WINDOWS TESTS"
            def result = sh "cd docker-volume-vsphere/; make test-e2e-windows"
         } catch (err){
           failTheBuild("Build failed")
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


def failTheBuild(String message) {
    def messageColor = "\u001B[32m"
    def messageColorReset = "\u001B[0m"

    currentBuild.result = "FAILURE"
    echo messageColor + message + messageColorReset
    error(message)
}
