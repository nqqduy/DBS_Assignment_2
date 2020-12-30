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
        <script src="js/Chart.min.js"></script>
        <script src="js/utils.js"></script>
        <style>
        canvas{
            -moz-user-select: none;
            -webkit-user-select: none;
            -ms-user-select: none;
        }
        </style>
        <div class="text-center">
            <button id="openDoanhThu" data-toggle="modal" data-target="#modalPhone"
                    class="btn btn-primary openInsertPhone">
                Tính doanh thu theo năm
            </button>
        </div>
        <canvas id="canvas"></canvas>
        <div class="text-center" id="tongDoanhThu"></div>
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
                <h4 class="modal-title">Tính doanh thu theo năm</h4>
            </div>
            <div class="modal-body">
                <div class="out-info">
                    <div class="form-group">
                        <label for="profits-year">Năm:</label>
                        <input type="number" class="form-control" id="profits-year"
                            value="2020">
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="xuatBieuDo">
                        <label class="form-check-label" for="xuatBieuDo">Xuất biểu đồ</label>
                    </div>
                    <div class="text-center">
                        <button id="cal-profits" data-dismiss="modal"
                                class="btn btn-primary">
                            Tính toán
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
function getConfig(dataYear, dataProfits) {
    var months = ['tháng 1', 'tháng 2', 'tháng 3', 'tháng 4', 'tháng 5',
        'tháng 6', 'tháng 7', 'tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 1l',
        'Tháng 12'];
    var config = {
        type: 'line',
        data: {
            labels: months,
            datasets: [{
                label: 'Doanh thu năm ' + dataYear + ' (Đơn vị: ngàn đồng)',
                backgroundColor: window.chartColors.blue,
                borderColor: window.chartColors.blue,
                data: dataProfits,
                fill: true
            }]
        }
    };
    return config;
}
function onclickProfits() {
    $('body').on('click', '#cal-profits', function (event) {
        var ctx = $('#canvas')[0].getContext('2d');
        var jqxhr = $.post( 'request.php', {profitsYear: $('#profits-year').val(),
                            req: 'cal-profits'},
            function(res) {
                try {
                    var data = $.parseJSON(res);
                } catch (err) {
                    alert(err);
                    alert(res);
                    return;
                }
                if (data.errNo == 0) {
                    if ($('#xuatBieuDo').is(":checked")) {
                        var config = getConfig($('#profits-year').val(),
                            data.dataProfits);
                        window.myLine = new Chart(ctx, config);
                    } else {
                        ctx.clearRect(0, 0, canvas.width, canvas.height);
                    }
                    $('#tongDoanhThu').html('<h3>Tổng doanh thu năm ' + 
                        $('#profits-year').val() + ': ' + (data.profits).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') +
                        ' ngàn đồng</h3>');
                } else {
                    alert(data.mes);
                }
            });
    });
}
$(document).ready(function() {
    onclickProfits();
})
</script>
<!-- //modal -->
<?php
require_once 'footer.php';
?>