# ToDo MVC + Packer + Jenkins (OCI) - Sample Package

This archive contains a sample Jenkins + Packer setup to build the ToDo MVC Node.js example
and bake it into a custom Ubuntu image in Oracle Cloud (OCI) using Packer.

Steps to use:
1. Upload this archive to your Jenkins server and extract it to a workspace (e.g., /var/lib/jenkins/workspace/todo_packer_oci).
2. In Jenkins, create the following credentials (as Secret Text in Jenkins Credentials):
   - oci-tenancy-ocid
   - oci-user-ocid
   - oci-fingerprint
   - oci-compartment-ocid
   - oci-ubuntu-image-ocid (the base Ubuntu image OCID)
3. Place your OCI API private key on the Jenkins server at: /var/lib/jenkins/.oci/oci_api_key.pem (owner jenkins, mode 600).
4. Install packer on the Jenkins machine and ensure 'packer' is in PATH.
5. Run the pipeline (Jenkinsfile). The pipeline will:
   - Clone the ToDo MVC repo
   - Build and package the Node.js example
   - Run Packer to create an OCI image with the app installed
6. When you launch a VM from the created image, the ToDo app will run as a systemd service on port 3000.

Notes:
- Adjust REGION and other env values in the Jenkinsfile as needed.
- If your Jenkins agent runs inside a restricted network, ensure it can reach OCI endpoints.
