
#import "@preview/basic-report:0.3.1": *

#show: it => basic-report(
  doc-category: "An toàn phần mềm và hệ thống - SE362.Q21",
  doc-title: "Privacy-Preserving Technologies:
Balancing Security and User Rights in 2025",
  author: "
Nhóm 13
23521224 Trương Hoàng Phúc
23520962 Võ Khôi Bình Minh",
  language: "vi",
  compact-mode: false,
  it,
)

#set page(margin: 1.75in)
#set par(leading: 0.55em, spacing: 0.55em, first-line-indent: 1.8em, justify: true)
#show heading: set block(above: 1.4em, below: 1em)

= Tóm tắt (Phúc)
#include "1_tom-tat.typ"

= Phần giới thiệu (Phúc)
#include "2_gioi-thieu.typ"

= Nội dung phân tích chuyên sâu
== Yêu cầu địa chỉ email và số điện thoại của người dùng (Minh)
#include "3_email-sdt.typ"

== Passkey, MFA, Biometric Authentication (Minh)
#include "7_auth.typ"

== Cookie theo dõi (Phúc)
#include "4_honey.typ"

== reCAPTCHA (Phúc)
#include "5_recaptcha.typ"

== Cloudflare's Turnstile (Phúc)
#include "6_cloudflare.typ"

== Anubis (Phúc)
#include "6.1_anubis.typ"

= Kết luận (Minh)
#include "8_ket-luan.typ"

= Tài liệu tham khảo
#bibliography("bib.bib")

