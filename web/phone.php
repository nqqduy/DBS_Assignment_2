<?php
/**
 * A Design by TranDucBinh
 * 
 * PHP version 7.4
 *
 * @category  PHP
 * @package   PHP_Phone
 * @author    Tran Duc Binh <binh.tran13579@hcmut.edu.vn>
 * @copyright 2020-2021 BinhTran Pty Ltd (ABN 77 084 670 600)
 * @license   https://github.com/binhtran432k/DBS_Assignment_2/blob/main/LICENSE \\
 * Apache Licence
 * @link      https://github.com/binhtran432k/DBS_Assignment_2
 */
require_once 'header.php';

$sql = "
SELECT IdNhanVien, HoTen, KieuNv, Email, CongTyVanChuyen.txtGioiTinh(GioiTinh)
    AS GioiTinh, DienThoai
FROM
(SELECT NvKho.* FROM
(SELECT IdNhanVien, Cccd, HoTen, CongTyVanChuyen.txtLoaiNv(LoaiNv) AS KieuNv,
DiaChiNha, Tinh, Email, GioiTinh, NgaySinh, Luong, MatKhau, TrangThaiNv
FROM CongTyVanChuyen.NvHoatDong
INNER JOIN CongTyVanChuyen.NhanVienKho
ON IdNhanVien = IdNvKho) AS NvKho
UNION ALL
SELECT NvVc.* FROM
(SELECT IdNhanVien, Cccd, HoTen, 'Nhân viên vận chuyển' AS KieuNv,
DiaChiNha, Tinh, Email, GioiTinh, NgaySinh, Luong, MatKhau, TrangThaiNv
FROM CongTyVanChuyen.NvHoatDong
INNER JOIN CongTyVanChuyen.NhanVienVanChuyen
ON IdNhanVien = IdNvVc) AS NvVc) AS NhanVien
LEFT JOIN CongTyVanChuyen.DienThoaiNv ON IdNhanVien = IdNv
ORDER BY IdNhanVien;
        ";
$q = $pdo->query($sql);
$q->setFetchMode(PDO::FETCH_ASSOC);
?>
<div class="about" id="phone">
    <div class="container">
        <h3 class="title">Quản lý Điện thoại</h3>
        <table id="phoneTable" class="table table-bordered table-condensed">
            <thead>
                <tr>
                    <th>ID Nhân viên</th>
                    <th>Họ tên</th>
                    <th>Loại nhân viên</th>
                    <th>Email</th>
                    <th>Giới tính</th>
                    <th>Điện thoại</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = $q->fetch()): ?>
                <tr>
                    <td><?php echo htmlspecialchars($row['IdNhanVien']) ?></td>
                    <td><?php echo htmlspecialchars($row['HoTen']); ?></td>
                    <td><?php echo htmlspecialchars($row['KieuNv']); ?></td>
                    <td><?php echo htmlspecialchars($row['Email']); ?></td>
                    <td><?php echo htmlspecialchars($row['GioiTinh']); ?></td>
                    <td><?php echo htmlspecialchars($row['DienThoai']); ?></td>
                    <td>
                        <?php
                        if ($row['DienThoai']) {
                            echo '<a href="#" data-toggle="modal"
                                class="openUpdatePhone"
                                data-target="#modalPhone" idnv=',
                                htmlspecialchars($row['IdNhanVien']),
                                ' dienthoai=',
                                htmlspecialchars($row['DienThoai']),
                                '>Sửa
                                </a> | <a href="#" data-toggle="modal"
                                    class="delete-dt" idnv=',
                                htmlspecialchars($row['IdNhanVien']),
                                ' dienthoai=',
                                htmlspecialchars($row['DienThoai']),
                                '>Xóa
                                </a>';
                        }
                        ?>
                    </td>
                </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
        <div class="text-center">
            <button id="openInsertPhone" data-toggle="modal"
                data-target="#modalPhone" class="btn btn-primary openInsertPhone">
                THÊM SỐ ĐIỆN THOẠI
            </button>
        </div>
    </div>
</div>
<!-- modal -->
<div class="modal about-modal fade" id="modalPhone" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Action</h4>
            </div>
            <div class="modal-body">
                <div class="out-info">
                    <div>
                        <div class="form-group">
                            <label for="dt-update">ID Nhân viên:</label>
                            <input type="number" class="form-control"
                                   id="idnv-modal">
                        </div>
                        <div class="form-group">
                            <label for="dt-update">Điện thoại:</label>
                            <input type="text" class="form-control" id="dt-modal">
                        </div>
                        <div class="text-center">
                            <button id="action-dt" data-dismiss="modal"
                                    class="btn btn-primary">
                                action
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //modal -->
<script>
function onclickPhone() {
    $('body').on('click', '#action-dt', function (event) {
        var actionType = $('#action-dt').attr('actiontype');
        if (actionType == 'update') {
            var jqxhr = $.post( 'request.php', {idNv: $('#idnv-modal').val(),
                                                dienThoai: $('#dt-modal').val(),
                                                oldDt: $('#action-dt').attr('olddt'),
                                                req: 'update-dt'},
                function(res) {
                    var data = $.parseJSON(res);
                    if (data.errNo == 0) {
                        $('#phoneTable').load('phone.php #phoneTable');
                    } else {
                        alert(data.mes);
                    }
                });
        } else if (actionType == 'insert') {
            var jqxhr = $.post( 'request.php', {idNv: $('#idnv-modal').val(),
                                                dienThoai: $('#dt-modal').val(),
                                                req: 'insert-dt'},
                function(res) {
                    var data = $.parseJSON(res);
                    if (data.errNo == 0) {
                        $('#phoneTable').load('phone.php #phoneTable');
                    } else {
                        alert(data.mes);
                    }
                });
        }
    });
    $('body').on('click', '.delete-dt', function (event) {
        var jqxhr = $.post( 'request.php', {idNv: $(this).attr('idnv'),
                                            dienThoai: $(this).attr('dienthoai'),
                                            req: 'delete-dt'},
            function(res) {
                var data = $.parseJSON(res);
                if (data.errNo == 0) {
                    $('#phoneTable').load('phone.php #phoneTable');
                } else {
                    alert(data.mes);
                }
            });
    });
    $('body').on('click', '.openUpdatePhone', function (event) {
        var idNv =  $(this).attr('idnv');
        var dienThoai =  $(this).attr('dienthoai');
        $('#idnv-modal').val( idNv );
        $('#idnv-modal').prop("readonly", true);
        $('#dt-modal').val( dienThoai );
        $('#modalPhone .modal-title').html( 'Sửa số điện thoại' );
        $('#action-dt').html( 'SỬA' );
        $('#action-dt').attr('actiontype', 'update');
        $('#action-dt').attr('olddt', dienThoai);
    });
    $('body').on('click', '.openInsertPhone', function (event) {
        var idNv =  $(this).attr('idnv');
        var dienThoai =  $(this).attr('dienthoai');
        $('#idnv-modal').val( idNv );
        $('#idnv-modal').prop("readonly", false);
        $('#dt-modal').val( dienThoai );
        $('#modalPhone .modal-title').html( 'Thêm số điện thoại' );
        $('#action-dt').html( 'THÊM' );
        $('#action-dt').attr('actiontype', 'insert');
    });
}
$(document).ready(function() {
    onclickPhone();
})
</script>
<?php
require_once 'footer.php';
?>