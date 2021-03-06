node("vdvs-slave-two") {

    def app
    
    def DIRECTORY = 'docker-volume-vsphere'
    def ERROR = 'false'
   
    dir('docker-volume-vsphere') {
       sh "echo Deleting ${DIRECTORY} "
       deleteDir()
    }
   
        stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

            checkout scm
        }

        stage('Build Linux plugin') {
        /* This builds the actual image */

            sh "echo BUILDING IMAGE NEW"
            sh "git clone https://github.com/ashahi1/docker-volume-vsphere.git"
            sh "cd \\${DIRECTORY}/; make build-all" 
        }

        stage('Deploy') {
        /* This deploys the actual code */

            sh "echo DEPLOYING IMAGE"
            sh "ls" 
            sh "echo ESX = $ESX; echo VM-1=$VM1; echo VM-2=$VM2; echo VM-3=$VM3;" 
            sh "cd \\${DIRECTORY}/; make deploy-all" 
            sh "echo FINISHED DEPLOYING THE IMAGE"
        }
    
        stage('Executing End-to-End Tests') {
            /* This runs the e2e test */
             
            sh "echo STARTING E2E TESTS" 
            sh "cd \${DIRECTORY}/; make test-e2e || ${ERROR}=true"
            sh "cd \${DIRECTORY}/; make test-esx || ${ERROR}=true"
            sh "cd \${DIRECTORY}/; make test-vm || ${ERROR}=true"
        }       


        stage('vFile Tests') {
         /* This runs the tests for vFile Plugin */
                   
            sh "echo Build, deploy and test vFile plugin"
            sh "cd docker-volume-vsphere/; make build-vfile-all ; make deploy-vfile-plugin; make test-e2e-vfile || ${ERROR}=true"
            
        }

        stage('Build Windows plugin') {
        /* This builds the actual windows image; */

            sh "echo BUILDING Windows IMAGE"
            sh "make build-windows-plugin"
            sh "echo FINISHED BUILDING IMAGE"
        }

        stage('Deploy Windows plugin') {
        /* This deploys the windows plugin image; */

            sh "echo DEPLOYING IMAGE"
            sh "ls"
            sh "echo Windows-VM = $WIN_VM1"
            sh "cd \${DIRECTORY}/; make deploy-windows-plugin"
            sh "echo FINISHED DEPLOYING THE IMAGE"

        }

        stage('Executing Windows Plugin Tests') {
         /* This runs the tests for Windows Plugin */
                  
                sh "echo STARTING WINDOWS TESTS"
                def result = sh "cd docker-volume-vsphere/; make test-e2e-windows"  
        }
        post {
            always {
         
                sh "echo CLEANUP"
                sh "cd \${DIRECTORY}/; make clean-all; rm -fr \${DIRECTORY}/"

               sh ''' 
                if [ ${ERROR} ]
                    then 
                        exit -1
                    fi '''

                sh "echo PIPELINE FINISHED"
            }
        }
}