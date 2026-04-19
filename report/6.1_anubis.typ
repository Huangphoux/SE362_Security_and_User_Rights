#set heading(offset: 2)

Anubis là một phần mềm tương tự như reCAPTCHA và Turnstile trong việc phân biệt cá thể muốn truy cập vào trang là bot hay con người. Anubis là phần mềm mã nguồn mở được tạo ra bởi Xe Iaso sau khi phát hiện đa số các bot không tuân thủ theo tiêu chuẩn lọc bot bằng `robots.txt`. Dù chỉ mới được công bố vào đầu năm 2025, Anubis đã được áp dụng vào nhiều dự án mã nguồn mở khác.

Anubis khác Turnstile ở việc không cần phải thu thập thông tin người dùng để phân biệt được, mà ngầm định việc trình duyệt của người dùng sẽ đủ mới để có thể sử dụng thuật toán SHA-256.

Anubis tiến hành kiểm tra người dùng nếu thoả mãn các điều kiện sau@anubis:
- Trong yêu cầu HTTP đến máy chủ, header `User-Agent` chứa cụm từ `Mozilla`: hầu như tất cả trình duyệt hiện nay đều gửi header `User-Agent` chứa `Mozilla` vì lí do đã từng có một trình duyệt tên "Mozilla" và lúc bấy giờ những trình duyệt khác đều giả làm Mozilla vì một số trang chỉ có thể hiện nội dung trên trình duyệt Mozilla. @mozilla Thật ra điều kiện này cũng không hữu dụng đến mấy vì đa số các bot đều đang sử dụng `User-Agent` chứa `Mozilla`.
- Địa chỉ yêu cầu không là `/.well-known` hoặc `/robots.txt`

Sau khi kiểm tra xong, nếu được xác nhận là người, trình duyệt sẽ lưu kết quả thành cookie để những lần truy cập trang web sau không cần phải kiểm tra người dùng nữa.

Quy trình kiểm tra được diễn ra như sau: Anubis sẽ gửi trình duyệt một dãy số ngẫu nhiên. Trình duyệt phải tìm một dãy số ngẫu nhiên, sao cho khi nối hai số này lại (số của Anubis đi trước) và băm bằng thuật toán SHA-256, kết quả phải có số lượng số không ở đầu theo Anubis yêu cầu (mặc định là 5 số không).

Việc băm thuật toán SHA-256 yêu cầu trình duyệt phải sử dụng được JavaScript. Đến giữa năm 2025, Anubis đã thêm một bài kiểm tra khác mà không cần sử dụng JavaScript bằng cách tận dụng tính năng Meta refresh của HTML, yêu cầu trình duyệt tự động tải lại trang sau một khoảng thời giand định trước.

Anubis đã chứng minh cho ta thấy, có thể phân biệt được người dùng truy cập là người hay máy mà không cần phải thu thập dữ liệu riêng tư của người dùng bằng việc tận dụng các tính năng hiện đại của trình duyệt, cũng như nắm thóp được tâm lí của những cá nhân vận hành những con bot: ngay từ đầu sử dụng bot là để tự động hoá việc truy cập, nếu mà giờ phải cố gắng cập nhật hệ thống để có thể chạy JavaScript, thì thà từ bỏ còn hơn.