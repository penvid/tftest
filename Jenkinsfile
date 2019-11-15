
node{

   stages{
        stage("terraform started"){
         steps{
             sh 'echo "started..." '
           }
            
         }
       stage('git clone'){
          steps{
              git clone https://github.com/penvid/tftest.git
          }
        }

       stage('terraform init'){
          steps{
              sh 'sudo /root/formactfproj/terraform init'
          }
        }

       stage('terraform init'){
          steps{
              sh 'sudo /root/formactfproj/terraform plan'
          }
        }

       stage("terraform ended"){
         steps{
             sh 'echo "ended..." '
           }
         }
   

   }

}
