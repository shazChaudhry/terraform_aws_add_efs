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
runcmd:
  - sleep 5m
  - sudo mkdir -p /efs
  - sudo mount -t efs ${efs_id}:/ /efs
  - echo '${efs_id}:/ /efs efs defaults,_netdev 0 0' | sudo tree -a /etc/fstab