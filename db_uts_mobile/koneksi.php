<?php

$koneksi = mysqli_connect("localhost", "root", "", "db_uts_mobile");

if ($koneksi) {

	// echo "Database berhasil Connect";

} else {
	echo "gagal Connect";
}
