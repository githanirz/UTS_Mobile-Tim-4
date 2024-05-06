    <?php

    header("Access-Control-Allow-Origin: *");
    include 'koneksi.php';

    if ($_SERVER['REQUEST_METHOD'] == "POST") {
        $response = array();

        $id = $_POST['id'];
        $nama_sejarah = $_POST['nama_sejarah'];
        $foto_sejarah = $_POST['foto_sejarah'];
        $tanggal_lahir = $_POST['tanggal_lahir'];
        $asal = $_POST['asal'];
        $jenis_kelamin = $_POST['jenis_kelamin'];
        $deskripsi = $_POST['deskripsi'];

        // Periksa apakah foto_sejarah baru telah diunggah

        $sql = "UPDATE tb_sejarah SET nama_sejarah = '$nama_sejarah', foto_sejarah = '$foto_sejarah', tanggal_lahir = '$tanggal_lahir', asal = '$asal', jenis_kelamin = '$jenis_kelamin', deskripsi = '$deskripsi' WHERE id = $id";


        // Jalankan query SQL untuk memperbarui data dalam database
        $isSuccess = $koneksi->query($sql);

        if ($isSuccess) {
            $cek = "SELECT * FROM tb_sejarah WHERE id = $id";
            $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
            $response['is_success'] = true;
            $response['value'] = 1;
            $response['message'] = "Sejarahwan Berhasil di Edit";
            $response['data'] = $result;
        } else {
            $response['is_success'] = false;
            $response['value'] = 0;
            $response['message'] = "Gagal Edit Sejarahwan";
        }

        echo json_encode($response);
    }
