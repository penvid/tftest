node{    
        String credentialsId = 'vidawsCred'

         def tfHome = tool name: 'Terraform'
         env.PATH = "${tfHome}:${env.PATH}"

         sh "terraform -version"

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
              credentialsId: credentialsId, 
             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                  sh 'terraform init'
             }
          
        }

        stage('terraform plan'){

          withCredentials([[
              $class: 'AmazonWebServicesCredentialsBinding',
              accessKeyVariable: 'AWS_ACCESS_KEY_ID',
              credentialsId: credentialsId,
             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                  sh 'terraform plan'
             }

        }


      stage('terraform apply'){

          withCredentials([[
              $class: 'AmazonWebServicesCredentialsBinding',
              accessKeyVariable: 'AWS_ACCESS_KEY_ID',
              credentialsId: credentialsId,
             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                  sh 'terraform apply -auto-approve'
             }

        }
       
      stage('terraform destroy'){

          withCredentials([[
              $class: 'AmazonWebServicesCredentialsBinding',
              accessKeyVariable: 'AWS_ACCESS_KEY_ID',
              credentialsId: credentialsId,
             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                  sh 'terraform destroy -auto-approve'
             }

        }
}         
