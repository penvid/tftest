node{    

        stage("terraform started"){
         
             sh 'echo "started..." '
           }
            
        
       stage('git pull'){
          
              git 'https://github.com/penvid/tftest.git'
          }
        

       stage('terraform init'){
          
              script: "terraform init"
          
        }

       stage('terraform execute'){
          
            script: "terraform apply"
         
        }

       stage("terraform ended"){
             sh 'echo "ended..." '
         }
   

}
