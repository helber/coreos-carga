
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
# Separando data e metadata
lvcreate -n data COREOS -L 90G
lvcreate -n metadata COREOS -L 10G
# SWAP
lvcreate -n SWP COREOS -L 12G
mkswap /dev/mapper/COREOS-SWP

# Formatar
mkfs.ext4 -L TOOLBOX /dev/mapper/COREOS-toolbox
mkfs.ext4 -L DOCKER /dev/mapper/COREOS-docker
# Montar
systemctl start  /var/lib/docker/
systemctl start  /var/lib/toolbox/
