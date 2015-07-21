
# Particionar
gdisk /dev/sda
# Criar partições
pvcreate /dev/sda1
# Criar volume fisico
vgcreate COREOS /dev/sda1
# Ativar
vgchange -ay
# Criar volumes logicos
lvcreate -n toolbox COREOS -L 20G
lvcreate -n docker COREOS -L 60G
# Formatar
mkfs.btrfs -L TOOLBOX /dev/mapper/COREOS-toolbox
mkfs.btrfs -L DOCKER /dev/mapper/COREOS-docker
# Montar
systemctl start  /var/lib/docker/
systemctl start  /var/lib/toolbox/

# SWAP
# lvcreate -n SWP COREOS -L 12G
# mkswap /dev/mapper/COREOS-SWP
