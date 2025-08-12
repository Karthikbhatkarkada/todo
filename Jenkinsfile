pipeline {
    agent any
    
    environment {
        OCI_TENANCY_OCID = 'ocid1.tenancy.oc1..aaaaaaaa6jvn6ty3gevdog7phzcnbh7x3ek4suj4cwyd7imjhe62qwv7x2iq'
        OCI_USER_OCID    = 'ocid1.user.oc1..aaaaaaaaaoc2keqeg3eivr4vadd4llduiput5fu5ftprtps3rt5o2rzmhz6q'
        OCI_KEY_FINGERPRINT = '49:85:65:68:89:5f:9e:4e:59:a8:e9:11:68:f5:b0:07'
        OCI_PRIVATE_KEY  = '/home/ubuntu/.ssh/oci_key'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Karthikbhatkarkada/todo'
            }
        }
        
        stage('Build Application') {
            steps {
                sh '''
                echo "Building application..."
                # Example for Node.js app:
                npm install
                npm run build
                '''
            }
        }
        
        stage('Packer Build') {
            steps {
                sh '''
                echo "Running Packer..."
                packer init packer-template.pkr.hcl
                packer build \
                    -var "oci_tenancy_ocid=$OCI_TENANCY_OCID" \
                    -var "oci_user_ocid=$OCI_USER_OCID" \
                    -var "oci_key_fingerprint=$OCI_KEY_FINGERPRINT" \
                    -var "oci_private_key_path=$OCI_PRIVATE_KEY" \
                    packer-template.pkr.hcl
                '''
            }
        }
    }
}
