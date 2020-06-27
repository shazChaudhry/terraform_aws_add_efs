#cloud-config
runcmd:
  - sleep 5m
  - sudo mkdir -p /efs
  - sudo mount -t efs ${efs_id}:/ /efs
  - echo '${efs_id}:/ /efs efs defaults,_netdev 0 0' | sudo tree -a /etc/fstab