<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia



    if (isset($_POST['nama_sejarah'])  && isset($_POST['tanggal_lahir'])) {
        $nama_sejarah = $_POST['nama_sejarah'];
        $foto_sejarah = $_POST['foto_sejarah'];
        $tanggal_lahir = $_POST['tanggal_lahir'];
        $asal = $_POST['asal'];
        $jenis_kelamin = $_POST['jenis_kelamin'];
        $deskripsi = $_POST['deskripsi'];


        // Checking if the required parameters are present

        $sql = "INSERT INTO tb_sejarah (nama_sejarah, foto_sejarah, tanggal_lahir, asal, jenis_kelamin,deskripsi) VALUES ('$nama_sejarah', '$foto_sejarah','$tanggal_lahir', '$asal', '$jenis_kelamin','$deskripsi')";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menambahkan data sejarawan";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menambahkan data sejarawan: " . $koneksi->error;
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);
