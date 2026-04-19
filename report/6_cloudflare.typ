#set heading(offset: 2)

Cloudflare Turnstile là một giải pháp phân biệt người dùng, được tạo ra để thay thế reCAPTCHA. Turnstile không yêu cầu người dùng phải sử dụng biện pháp chứng minh nào khác ngoài việc bấm vào ô vuông, kể cả khi không thể xác định được là người hay máy. Ngoài ra, Turnstile không gửi hay sử dụng bất cứ dữ liệu nào của người dùng cho việc xác minh, khác với reCAPTCHA.

Thế nhưng, Turnstile vẫn gửi những thông tin sau đến Cloudflare: địa chỉ IP, TLS Fingerprint, header `User-Agent` và `Origin`. Cloudflare cho rằng sử dụng những thông tin đó nhằm mục đích "Phát hiện và ngăn chặn các bot" và "Cải thiện tính năng phát hiện của Turnstile". @turnstile

Dù đã ghi rõ trong chính sách bảo mật của Cloudflare, không nên để việc thu thập thông tin người dùng khi chưa có được sự xin phép tiếp tục diễn ra, tương tự như cookie trước khi bị luật ban hành yêu cầu phải xin phép ý kiến của người dùng. Điều đó làm đặt ra câu hỏi: Liệu có công nghệ nào có thể phân biệt người và máy mà có thể hoạt động không cần phải thu thập thông tin người dùng không?