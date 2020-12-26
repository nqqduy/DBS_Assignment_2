# DBS_Assignment_2
## PHẦN 1: TẠO CSDL (3đ)
### 1. (2đ) Tạo Cơ sở dữ liêu (CSDL) như đã được phân tích và thiết kế ở bài tập lớn số 1.
- Lược đồ CSDL đã được thiết kế đó có thể được cập nhật và chuẩn hóa lại nếu thấy chưa hợp lý.
- Các ràng buộc khóa chính, khoá ngoại, ràng buộc dữ liệu, ràng buộc ngữ nghĩa (có thể đã được nêu trong bài tập lớn 1 hoặc chưa nêu) cần được hiện thực (cố thể sử dụng Check hoặc Trigger).
- In lại lược đồ CSDL mới vào báo cáo.
### 2. (1đ) Tạo dữ liệu mẫu có ý nghĩa để minh họa cho các yêu cầu ở bên dưới. (Có thể nhập bằng giao diện). Mỗi bảng co tối thiểu 5 dòng
## PHẦN 2: HIỆN THỰC ỨNG DỤNG (7đ)
### 1. (1đ) Viết các thủ tục để thêm (insert), sửa (update), xóa (delete) dữ liệu vào một bảng.
  Yêu cầu:
  - Phải có hiện thực việc kiểm tra dữ liệu hợp lệ (validate) để đảm bảo các ràng buộc của bảng dữ liệu.
  - Xuất ra thông báo lỗi có nghĩa, chỉ ra lỗi sai cụ thể (không ghi chung chung là "Lỗi nhập liệu!"). Ví dụ : trọng lượng kiện hàng > 0 , số điện thoại cố kiểu dữ liệu hợp lệ là 10 chữ số bắt đầu là 0, ngày nhận hàng > ngày gởi hàng của cùng món hàng,...
### 2. (1.5đ) Viết ít nhất 2 trigger để kiểm soát các hành động INSERT, UPDATE, DELETE trên một số bảng đã tạo. Sao cho có ít nhất 1 trigger có tính toán cập nhật dữ liệu trên bảng dữ liệu khác bảng đang được thiết lập trigger (chú ý đến các trigger để tính toán thuộc tính dẫn xuất)
### 3. (1.5đ) Viết ít nhất 2 thủ tục trong đó chỉ chứa các câu truy vấn để hiển thị dữ liệu.
  Trong đó, tham số đầu vào sẽ được sử dụng trong mệnh đề WHERE hoặc HAVING, gồm:
  - 1 câu truy vấn sử dụng 2 bảng trở lên có mệnh đề WHERE, ORDER BY.
  - 1 câu truy vấn sử dụng hàm bao gộp (aggregate function)
  - Cần chuẩn bị sẵn dữ liệu để minh họa cho việc gọi thủ tục.
### 4. (1đ) Viết ít nhát 2 hàm bất kì. Yêu cầu chuẩn bị dữ liệu để minh họa cho việc gọi hàm.
### 5. (2đ) Viết ứng dụng (web / mobile) minh họa việc kết nối ứng dụng với CSDL. Trong đó :
- Có giao diện phục vụ cho chức năng thêm dữ liệu vào bảng dữ liệu trong câu 1.
- Có giao diện hiển thị danh sách dữ liệu từ việc gọi thủ tục trong câu 3. Cần có chức năng phụ như search, filter, sắp xếp,...
- Ứng dụng có giao diện đẹp, các chức năng được làm thêm phong phú, có độ phức tạp, hướng người dùng,... sẽ được cộng điểm.
