locals {
webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
sudo apt update && sudo apt full-upgrade -y
sudo apt install docker.io -y

CUSTOM_DATA  
}