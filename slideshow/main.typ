#import "@preview/diatypst:0.8.0": *

#show: slides.with(
  title: "Privacy-Preserving Technologies:
Balancing Security and User Rights in 2025",
  subtitle: "An toàn phần mềm và hệ thống - SE362.Q21",
  date: datetime.today().display(),
  authors: "23521224 Trương Hoàng Phúc
23520962 Võ Khôi Bình Minh",

  ratio: 4 / 3,
  layout: "small",
  title-color: blue,
  toc: true,
  theme: "normal",
  count: "number",
)

= Địa chỉ email và số điện thoại của người dùng

= Passkey, MFA, Biometric Authentication

= Cookie theo dõi
- Cookie: dữ liệu máy chủ gửi và lưu trên máy người dùng để sử dụng trong những lần sau.
- Vì có thể bị lợi dụng để theo dõi, giờ đây các trang web phải có được sự cho phép thì mới được lưu trữ cookie trên máy người dùng.
- Cookie bên thứ ba: khi trang web yêu cầu tài nguyên từ bên thứ ba, bên này có thể sử dụng cookie để theo dõi người dùng.
- Hiện nay, đa số các trình duyệt đều có cài đặt để chặn các cookie bên thứ ba, nhưng mặc định bị tắt.

= reCAPTCHA
#image("../report/images/recaptcha.gif")
- reCAPTCHA là CAPTCHA được cải tiến bởi Google, được sử dụng để xác định người muốn truy cập trang web là người thật hay người máy.
- reCAPTCHA sử dụng cookie và địa chỉ IP để xác định. Còn nhiều thông số mà Google không thể công khai để tránh việc bị lợi dụng và rò rỉ dữ liệu riêng tư của người dùng.

- reCAPTCHA bản 3 phải được nhúng vào toàn bộ các trang của trang web để âm thầm theo dõi người dùng xuyên suốt các trang, và chỉ hiện khi không thể xác định được là người hay máy.
- Có nghiên cứu phát hiện reCAPTCHA sử dụng cookie lưu trữ tài khoản Google của người dùng cho việc xác định.

= Turnstile của Cloudflare
#image("../report/images/turnstile.png")

- Turnstile của Cloudflare được tạo ra để thay thế reCAPTCHA, không yêu cầu người dùng phải sử dụng biện pháp chứng minh nào khác ngoài việc bấm vào ô vuông, kể cả khi không thể xác định được là người hay máy.
- Turnstile vẫn gửi những thông tin của người dùng đến Cloudflare: địa chỉ IP, TLS Fingerprint, header `User-Agent` và `Origin`, cho rằng những thông tin này nhằm mục đích "Phát hiện và ngăn chặn các bot" và "Cải thiện tính năng phát hiện của Turnstile".

= Anubis
#image("../report/images/anubis.png")
- Anubis không thu thập thông tin người dùng để xác định, mà ngầm định trình duyệt đủ hiện đại để sử dụng được thuật toán SHA-256.
- Quy trình xác định: Anubis gửi một dãy số ngẫu nhiên. Trình duyệt phải tìm một dãy số ngẫu nhiên, sao cho khi nối hai số này lại (số của Anubis đi trước) và băm bằng thuật toán SHA-256, kết quả phải có số lượng số không ở đầu theo Anubis yêu cầu (mặc định là 5 số không).

= Q&A

#align(center + horizon)[
  #text(size: 28pt, weight: "bold")[
    Thank You!
  ]

]
