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
?>
<div class="about" id="search-wrap">
    <div class="container">
        <h3 class="title">Tìm kiếm nhân viên</h3>
        <form action="search-employees.php" method="get">
        <div class="input-group">
            <input id="search-box" name="search-str" type="text" class="form-control"
                   placeholder="Tìm kiếm">
            <div class="input-group-btn">
            <button id="search-btn" name="search-nv" class="btn btn-default"
                    type="submit">
                <i class="fa fa-search"></i>
            </button>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <label for="sort-nv">Sắp xếp theo tên:</label>
                <select name="sort-nv" id="sort-nv" class="form-control">
                    <option value="1">A - Z</option>
                    <option value="0" selected="selected">Không sắp xếp</option>
                    <option value="-1">Z - A</option>
                </select>
            </div>
            <div class="col-md-6">
                <label for="kieu-nv">Kiểu nhân viên:</label>
                <select name="kieu-nv" id="kieu-nv" class="form-control">
                    <option value="0">Nhân viên vận chuyển</option>
                    <option value="1">Nhân viên kho</option>
                    <option value="2" selected="selected">Tất cả</option>
                </select>
            </div>
        </div>
        </form>
        <div class="text-center">
            <label for="searchTable">Bảng nhân viên</label>
        </div>
        <table id="searchTable" class="table table-bordered table-condensed">
            <thead>
                <tr>
                    <th>ID Nhân viên</th>
                    <th>CCCD</th>
                    <th>Họ tên</th>
                    <th>Loại nhân viên</th>
                    <th>Địa chỉ nhà</th>
                    <th>Tỉnh</th>
                    <th>Email</th>
                    <th>Giới tính</th>
                    <th>Ngày sinh</th>
                    <th>Lương (Ngàn đồng)</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if (isset($_GET['search-nv'])) {
                    $sql = "CALL CongTyVanChuyen.searchNhanVien(?, ?, ?);";
                    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
                    $stmt = $pdo->prepare($sql);
                    $stmt->execute([$_GET['search-str'], $_GET['kieu-nv'], $_GET['sort-nv']]);
                    ?>
                    <script>
                        $(document).ready(function() {
                            $('#search-box').val('<?php echo $_GET['search-str'] ?>');
                            $('#kieu-nv').val('<?php echo $_GET['kieu-nv'] ?>');
                            $('#sort-nv').val('<?php echo $_GET['sort-nv'] ?>');
                            $(document).ready(function() {
                                $('html,body').animate({
                                    scrollTop: $("#search-wrap").offset().top
                                }, 900);
                            });
                        });
                    </script>
                    <?php 
                    while ($row = $stmt->fetch()):?>
                    </tr>
                        <td><?php echo htmlspecialchars($row['IdNhanVien']); ?></td>
                        <td><?php echo htmlspecialchars($row['Cccd']); ?></td>
                        <td><?php echo htmlspecialchars($row['HoTen']); ?></td>
                        <td><?php echo htmlspecialchars($row['KieuNv']); ?></td>
                        <td><?php echo htmlspecialchars($row['DiaChiNha']); ?></td>
                        <td><?php echo htmlspecialchars($row['Tinh']); ?></td>
                        <td><?php echo htmlspecialchars($row['Email']); ?></td>
                        <td><?php echo htmlspecialchars($row['GioiTinh']); ?></td>
                        <td><?php
                            $ngaySinh = date('m/d/Y', strtotime($row['NgaySinh']));
                            echo htmlspecialchars($ngaySinh); ?></td>
                        <td><?php echo htmlspecialchars(number_format($row['Luong'], 2, '.', ',')); ?></td>
                    </tr>
                    <?php endwhile;
                } ?>
            </tbody>
        </table>
    </div>
</div>
<?php
require_once 'footer.php';
?>