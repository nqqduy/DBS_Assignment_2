<?php
require_once 'dbconfig.php';
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    // echo "Connected to $dbname at $host successfully.";
} catch (PDOException $pe) {
    die("Could not connect to the database $dbname :" . $pe->getMessage());
    exit();
}
if (isset($_POST['req'])) {
    if ($_POST['req'] == 'insert-dt') {
        $sql = "
                CALL CongTyVanChuyen.insertDienThoaiNv(?, ?);
                ";
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$_POST['idNv'], $_POST['dienThoai']]);
        if ($stmt->errorInfo()[0] != '00000') {
            $res['errNo'] = 1;
            $res['mes'] = $stmt->errorInfo()[2];
            echo json_encode($res);
        } else {
            $res['errNo'] = 0;
            $res['mes'] = null;
            echo json_encode($res);
        }
    } else if ($_POST['req'] == 'update-dt') {
        $sql = "
                CALL CongTyVanChuyen.updateDienThoaiNv(?, ?, ?);
                ";
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$_POST['idNv'], $_POST['oldDt'], $_POST['dienThoai']]);
        if ($stmt->errorInfo()[0] != '00000') {
            $res['errNo'] = 1;
            $res['mes'] = $stmt->errorInfo()[2];
            echo json_encode($res);
        } else {
            $res['errNo'] = 0;
            $res['mes'] = null;
            echo json_encode($res);
        }
    } else if ($_POST['req'] == 'delete-dt') {
        $sql = "
                CALL CongTyVanChuyen.deleteDienThoaiNv(?, ?);
                ";
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$_POST['idNv'], $_POST['dienThoai']]);
        if ($stmt->errorInfo()[0] != '00000') {
            $res['errNo'] = 1;
            $res['mes'] = $stmt->errorInfo()[2];
            echo json_encode($res);
        } else {
            $res['errNo'] = 0;
            $res['mes'] = null;
            echo json_encode($res);
        }
    } else if ($_POST['req'] == 'cal-profits') {
        $sql = "
                CALL CongTyVanChuyen.doanhThuNam(?, 1, @doanhThu);
                ";
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$_POST['profitsYear']]);
        if ($stmt->errorInfo()[0] != '00000') {
            $res['errNo'] = 1;
            $res['mes'] = $stmt->errorInfo()[2];
            echo json_encode($res);
        } else {
            $dataProfits = [];
            $monthWalker = 1;
            $doanhThu = 0;
            while ($row = $stmt->fetch()):
                $curMonth = $row['Thang'];
                while ($monthWalker < $curMonth) {
                    array_push($dataProfits, 0);
                    $monthWalker += 1;
                }
                array_push($dataProfits, $row['TongDoanhThu']);
                $doanhThu += $row['TongDoanhThu'];
            endwhile;
            while ($monthWalker < 12):
                if ($monthWalker == 1) {
                    array_push($dataProfits, 0);
                }
                $monthWalker += 1;
                array_push($dataProfits, 0);
            endwhile;
            $res['errNo'] = 0;
            $res['mes'] = null;
            $res['dataProfits'] = $dataProfits;
            $res['profits'] = $doanhThu;
            echo json_encode($res);
        }
    }
    exit();
}
?>