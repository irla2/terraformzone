provider "aws" {
    access_key= "${var.access_key}"
    secret_key= "${var.secret_key}"
    region= "us-east-2"      
}
resource "aws_instance" "app" {
    ami= "ami-0ebbf2179e615c338"
    instance_type= "t2.micro"
    key_name= "new"
    security_groups = ["packer"]
    tags={
        Name= "app"
    }

 connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("./new.pem")}"
  }
  provisioner "chef"{
    environment     = "_default"
    run_list        = ["ramu::default"]
    node_name       = "chef-node"
    server_url      = "https://manage.chef.io/organizations/ramanj"
    recreate_client = true
    user_name       = "iramu053@gmail.com"
    user_key        = "${file("./irla.pem")}"
    version         = "12.4.1"
}
provisioner "file"{
      source= "/tmp/gameoflife.war"
      destination= "/opt/tomcat/webapps"
  }
}
