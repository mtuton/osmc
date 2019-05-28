#!/bin/bash

mkdir -p ${DIR}
debootstrap --no-check-gpg --arch=${ARCH} --foreign --variant=minbase ${RLS} ${DIR} ${URL}
cp /usr/bin/${ARM_EMULATOR} ${DIR}/usr/bin/${ARM_EMULATOR}
cp -r /usr/share/keyrings ${DIR}/usr/share/keyrings

chroot ${DIR} /debootstrap/debootstrap --second-stage
cp /etc/resolv.conf ${DIR}/etc/resolv.conf

cp sources.list ${DIR}/etc/apt/sources.list

chroot ${DIR} mount -t proc proc /proc
wget "http://apt.osmc.tv/osmc_repository.gpg" -O ${DIR}/etc/apt/trusted.gpg.d/osmc_repository.gpg
chroot ${DIR} apt-get update
chroot ${DIR} apt-get -y install --no-install-recommends build-essential nano sudo libeatmydata1
chroot ${DIR} apt-get -y install --no-install-recommends ccache
mkdir -p ${DIR}/root/.ccache

rm -f ${DIR}/etc/resolv.conf 
rm -f ${DIR}/etc/network/interfaces
rm -rf ${DIR}/usr/share/man/*
rm -rf ${DIR}/var/lib/apt/lists/*
rm -f ${DIR}/var/log/*.log
rm -f ${DIR}/var/log/apt/*.log
rm -f ${DIR}/tmp/reboot-needed
chroot ${DIR} apt-get clean

chroot ${DIR} umount /proc
rm ${DIR}/usr/bin/${ARM_EMULATOR}

# RUN build_deb_package "${wd}" "${tcstub}"
wd=$(pwd)
mkdir -p ${wd}/output
cp -ar ${wd}/DEBIAN ${wd}/output
mv ${wd}/opt ${wd}/output
#target=$(echo $1 | rev | cut -d / -f 1 | rev | cut -d - -f 1)
mkdir -p ${wd}/output/opt/osmc-tc/${target}-toolchain-osmc
echo ${tcstub} >${wd}/output/opt/osmc-tc/${target}-toolchain-osmc/tcver.${target}

# dpkg_build ${1}/output ${2}.deb
sed '/^Installed-Size/d' -i "${wd}/output/DEBIAN/control"
size=$(du -s --apparent-size "${wd}/output" | awk '{print $1}')
echo "Installed-Size: $size" >> "${wd}/output/DEBIAN/control"
dpkg -b "${wd}/output" "${tcstub}.deb"
