node{    

        stage("terraform started"){
         
             sh 'echo "started..." '
           }
            
        
       stage('git pull'){
          
              git 'https://github.com/penvid/tftest.git'
          }
        

       stage('terraform init'){
          
           sh 'terraform init'
          
        }

       stage('terraform execute'){
          
           sh 'terraform apply'
         
        }

       stage("terraform ended"){
             sh 'echo "ended..." '
         }
   

}
