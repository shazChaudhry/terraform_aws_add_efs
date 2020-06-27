#cloud-config
repo_update: true
repo_upgrade: all
packages:
  - amazon-efs-utils
  - tree
users:
  - name: admin
    groups: [ wheel ]
    sudo: [ "ALL=(ALL) NOPASSWD:ALL" ]
    shell: /bin/bash
    ssh-authorized-keys:
      - ${public_key}