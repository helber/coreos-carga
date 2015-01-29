

centos 7:
erro:internal error: early end of file from monitor: possible problem:
qemu-kvm: -device virtio-9p-pci,id=fs0,fsdev=fsdev-fs0,mount_tag=config-2,bus=pci.0,addr=0x3: 'virtio-9p-pci' is not a valid device model name

http://elrepo.org/tiki/tiki-index.php
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
yum --enablerepo=elrepo-kernel install kernel-ml


modprobe 9pnet_rdma
modprobe 9pnet_virtio
modprobe 9p
modprobe 9pnet

Recriando o pacote qemu:
http://scientificlinuxforum.org/index.php?showtopic=2858

http://dl.fedoraproject.org/pub/epel/7/SRPMS/repoview/qemu.html

edit qemu.spec
cd /home/lang/rpmbuild/SPECS/
cp qemu.spec qemu-2.0.epel.src.rpm.orig.spec (make backup of original)


vi qemu.spec

%if 0%{?rhel}
# RHEL-specific defaults:
%bcond_with    kvmonly          # enabled
%bcond_with    exclusive_x86_64 # enabled for my install -> i changed this 'without' -> 'with'
%bcond_with    rbd              # disabled
%bcond_without spice            # enabled
%bcond_without seccomp          # enabled
%bcond_without xfsprogs         # disabled
%bcond_with    separate_kvm     # disabled for EPEL but enabled for my install -> i changed this 'without' -> 'with'
%bcond_without gtk              # disabled
%else
