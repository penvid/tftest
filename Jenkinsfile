pipeline{
     agent any
    stages{
        stage("terraform started"){
         steps{
             sh 'echo "started..." '
           }
            
         }
       stage('git pull'){
          steps{
              git 'https://github.com/penvid/tftest.git'
          }
        }

       stage('terraform init'){
          steps{
              sh '/var/lib/jenkins/workspace/firsttf/terraform init'
          }
        }

       stage('terraform execute'){
          steps{
              sh '/var/lib/jenkins/workspace/firsttf/terraform apply'
          }
        }

       stage("terraform ended"){
         steps{
             sh 'echo "ended..." '
           }
         }
   
}

}
