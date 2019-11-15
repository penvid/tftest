node{    

        stage("terraform started"){
         
             sh 'echo "started..." '
           }
            
        
       stage('git pull'){
          
              git 'https://github.com/penvid/tftest.git'
          }
        

       stage('terraform init'){
          
          withCredentials([[
              $class: 'AmazonWebServicesCredentialsBinding',
              accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
              credentialsId: 'vidawsCred', 
             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                  sh 'terraform init'
             }
          
        }

        stage('terraform plan'){

          withCredentials([[
              $class: 'AmazonWebServicesCredentialsBinding',
              accessKeyVariable: 'AWS_ACCESS_KEY_ID',
              credentialsId: 'vidawsCred',
             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                  sh 'terraform plan'
             }

        }


      stage('terraform apply'){

          withCredentials([[
              $class: 'AmazonWebServicesCredentialsBinding',
              accessKeyVariable: 'AWS_ACCESS_KEY_ID',
              credentialsId: 'vidawsCred',
             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                  sh 'terraform apply'
             }

        }
       
}         
