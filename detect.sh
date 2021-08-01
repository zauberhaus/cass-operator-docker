#!/bin/sh

A1=$(readelf -h /sbin/apk | grep "Machine:" | awk -F: '{ print $2}' | xargs) 
A2=$(readelf -A /sbin/apk | grep "Tag_CPU_arch:" | awk -F: '{ print $2}' | xargs)  
ARCH="$A1$A2"

echo "Search: >$ARCH<"

case "$A1$A2" in
	*X86-64*)
		ARCH="x86_64"
		;;
	*80386*)
		ARCH="x86"
		;;
	"PowerPC64")
		ARCH="ppc64le"
		;;
	"IBM S/390")
		ARCH="s390x"
		;;
	ARMv7*)
		ARCH="armv7"
		;;
	ARMv6*)
		ARCH="armv6"
		;;
	*)
		echo "Sorry, unknown architecture"
        exit 1
		;;
esac

echo "Arch: $ARCH"
cp /build/operator.$ARCH /operator