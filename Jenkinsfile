pipeline {
    agent any

    environment {
        TENANCY_OCID      = credentials('oci-tenancy-ocid')
        USER_OCID         = credentials('oci-user-ocid')
        FINGERPRINT       = credentials('oci-fingerprint')
        PRIVATE_KEY_PATH  = '/var/lib/jenkins/.oci/oci_api_key.pem'
        REGION            = 'ap-hyderabad-1'
        COMPARTMENT_OCID  = credentials('oci-compartment-ocid')
        BASE_IMAGE_OCID   = credentials('oci-ubuntu-image-ocid')
    }

    stages {
        stage('Checkout & Build') {
            steps {
                sh 'chmod +x build.sh && ./build.sh'
            }
        }

        stage('Packer Build OCI Image') {
            steps {
                dir('packer') {
                    sh """
                    packer init ubuntu-oci.pkr.hcl
                    packer build \\
                      -var 'tenancy_ocid=${TENANCY_OCID}' \\
                      -var 'user_ocid=${USER_OCID}' \\
                      -var 'fingerprint=${FINGERPRINT}' \\
                      -var 'private_key_path=${PRIVATE_KEY_PATH}' \\
                      -var 'region=${REGION}' \\
                      -var 'compartment_ocid=${COMPARTMENT_OCID}' \\
                      -var 'base_image_ocid=${BASE_IMAGE_OCID}' \\
                      ubuntu-oci.pkr.hcl
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ OCI Ubuntu image with ToDo app created successfully!"
        }
        failure {
            echo "❌ Build failed!"
        }
    }
}
