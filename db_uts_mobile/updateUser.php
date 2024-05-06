<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';


$id_user = $_POST['id_user'];
$username = $_POST['username'];
$nama = $_POST['nama'];
$nohp = $_POST['nohp'];
$email = $_POST['email'];


$sql = "UPDATE tb_user SET username='$username', nama='$nama', nohp='$nohp', email='$email' WHERE id_user='$id_user'";
$isSuccess = $koneksi->query($sql);

if ($isSuccess) {
    $cek = "SELECT * FROM tb_user WHERE id_user =$id_user";
    $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
    $response['is_success'] = true;
    $response['value'] = 1;
    $response['message'] = "User Berhasil di Edit";
    $response['username'] = $result['username'];
    $response['nama'] = $result['nama'];
    $response['nohp'] = $result['nohp'];
    $response['email'] = $result['email'];
    $response['id_user'] = $result['id_user'];
} else {
    $response['is_success'] = false;
    $response['value'] = 0;
    $response['message'] = "Gagal Edit User";
}

echo json_encode($response);
