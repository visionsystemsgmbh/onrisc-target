platform_check_image() {
	case "$(get_magic_long "$1")" in
		68737173) 
			return 0
		;;
		*)
			echo "Invalid image type"
			return 1
		;;
	esac
}

platform_do_upgrade() {
       	// let barebox do the work
}

move_firmware() {
	cp /tmp/firmware.img /overlay/
}

append sysupgrade_pre_upgrade move_firmware
