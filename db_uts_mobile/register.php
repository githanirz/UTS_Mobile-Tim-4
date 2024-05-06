<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {

    $response = array();
    $username = $_POST['username'];
    $nama = $_POST['nama'];
    $nohp = $_POST['nohp'];
    $email = $_POST['email'];
    $password = md5($_POST['password']);


    $cek = "SELECT * FROM tb_user WHERE username = '$username' OR email = '$email'";
    $result = mysqli_query($koneksi, $cek);

    if (mysqli_num_rows($result) > 0) {
        $response['value'] = 2;
        $response['message'] = "Username atau email telah digunakan";
        echo json_encode($response);
    } else {
        $insert = "INSERT INTO tb_user (username, nama, nohp, email, password, created) 
                   VALUES ('$username','$nama','$nohp', '$email', '$password', NOW())";

        if (mysqli_query($koneksi, $insert)) {
            $response['value'] = 1;
            $response['username'] = $username;
            $response['nama'] = $nama;
            $response['nohp'] = $nohp;
            $response['email'] = $email;
            $response['password'] = $password;

            $response['message'] = "Registrasi Berhasil";
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal Registrasi";
            echo json_encode($response);
        }
    }
}
