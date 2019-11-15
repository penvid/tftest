
node{

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
              sh 'sudo /root/formactfproj/terraform init'
          }
        }

       stage('terraform execute){
          steps{
              sh 'sudo /root/formactfproj/terraform apply'
          }
        }

       stage("terraform ended"){
         steps{
             sh 'echo "ended..." '
           }
         }
   

   }

}
