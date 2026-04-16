from starhtml import *
import base64
from Crypto.Cipher import AES, DES, PKCS1_OAEP
from Crypto.Random import get_random_bytes
from Crypto.PublicKey import RSA


def b64e(b: bytes) -> str:  # mendox-sigh
    return base64.b64encode(b).decode("ascii")


def b64d(s: str) -> bytes:
    return base64.b64decode(s.strip().encode("ascii"))


app, rt = star_app(
    hdrs=(Link(rel="stylesheet", href="https://cdn.simplecss.org/simple.min.css"),),
)


@rt("/")
def index():
    return Main(
        nonce := Signal("nonce", ""),
        tag := Signal("tag", ""),
        khoa_priv := Signal("khoa_priv", ""),
    )(
        Div(
            Label(_for="nguyen_ven")("Nguyên vẹn"),
            Textarea(
                id="nguyen_ven",
                data_bind="nguyen_ven",
            ),
        ),
        Div(
            Label(_for="ket_qua")("Kết quả"),
            Textarea(
                id="ket_qua",
                data_bind="ket_qua",
            ),
        ),
        Div(style="grid-column: 1 / 3")(
            Label(_for="khoa")("Khoá"),
            Textarea(id="khoa", data_bind="khoa", disabled=True),
        ),
        Label(_for="thuat_toan")("Thuật toán"),
        Div(style="display: flex; gap: 1rem;")(
            Select(id="thuat_toan", data_bind="thuat_toan")(
                Option(value="des")("DES"),
                Option(value="aes")("AES"),
                Option(value="rsa")("RSA"),
            ),
        ),
        Label(_for="bit")("Số bit"),
        Div(style="display: flex; gap: 1rem;")(
            Select(id="bit", data_bind="bit")(
                Option(value="8")("(DES) 64 bit = 8 byte"),
                Option(value="16")("(AES) 128 bit = 16 byte"),
                Option(value="24")("(AES) 192 bit = 24 byte"),
                Option(value="32")("(AES) 256 bit = 32 byte"),
                Option(value="128")("(RSA) 1024 bit = 128 byte"),
                Option(value="256")("(RSA) 2048 bit = 256 byte"),
                Option(value="384")("(RSA) 3072 bit = 384 byte"),
            ),
            Button(
                data_on_click=post("/khoa"),
                data_indicator="loading",
            )(
                Span(data_show="!$loading")("Khoá ngẫu nhiên"),
                Span(data_show="$loading")("Đang tạo khoá …"),
            ),
        ),
        Div(
            style="display: flex; gap: 1rem; align-items: center; justify-content: center;"
        )(
            Button(data_on_click=post("/ma_hoa"))("Mã hoá"),
            Button(data_on_click=post("/giai_ma"))("Giải mã"),
            Button(data_on_click=post("/dat_lai"))("Đặt lại"),
        ),
        Div(style="display: flex; justify-content: center;")(
            Button(
                data_on_click="$nguyen_ven = 'The quick brown fox jumps over the lazy dog.'"
            )("Ví dụ dữ liệu nguyên vẹn"),
        ),
        Pre(data_json_signals=True),
    )


@rt("/ma_hoa")
@sse
async def ma_hoa(req, nguyen_ven: str, khoa: str, thuat_toan: str):
    if thuat_toan == "aes":
        aes = AES.new(b64d(khoa), AES.MODE_EAX)

        ciphertext, tag = aes.encrypt_and_digest(nguyen_ven.encode("utf-8"))

        yield signals(
            ket_qua=b64e(ciphertext),
            nonce=b64e(aes.nonce),
            tag=b64e(tag),
        )

    if thuat_toan == "des":
        des = DES.new(key=b64d(khoa), mode=DES.MODE_EAX)

        yield signals(
            ket_qua=b64e(des.encrypt(nguyen_ven.encode("utf-8"))),
            nonce=b64e(des.nonce),  # ty:ignore[unresolved-attribute]
        )

    if thuat_toan == "rsa":
        rsa = PKCS1_OAEP.new(RSA.import_key(khoa))

        yield signals(
            ket_qua=b64e(rsa.encrypt(nguyen_ven.encode("utf-8"))),
        )


@rt("/giai_ma")
@sse
async def giai_ma(
    req,
    ket_qua: str,
    khoa: str,
    khoa_priv: str,  # xài thuật toán khác thì khoa_priv chưa khởi tạo
    nonce: str,
    tag: str,
    thuat_toan: str,
):
    if thuat_toan == "aes":
        aes = AES.new(b64d(khoa), AES.MODE_EAX, nonce=b64d(nonce))

        yield signals(
            nguyen_ven=aes.decrypt_and_verify(b64d(ket_qua), b64d(tag)).decode("utf-8")
        )

    if thuat_toan == "des":
        des = DES.new(b64d(khoa), DES.MODE_EAX, nonce=b64d(nonce))

        yield signals(
            nguyen_ven=des.decrypt(b64d(ket_qua)).decode("utf-8"),
        )

    if thuat_toan == "rsa":
        rsa = PKCS1_OAEP.new(
            RSA.import_key(khoa_priv, passphrase="put-a-real-pass-here")
        )

        yield signals(
            nguyen_ven=rsa.decrypt(b64d(ket_qua)).decode("utf-8"),
        )


@rt("/dat_lai")
@sse
async def dat_lai(req):
    yield signals(
        nguyen_ven="",
        ket_qua="",
        khoa="",
        nonce="",
        tag="",
        thuat_toan="",
        bit="",
        khoa_priv="",
    )


@rt("/khoa")
@sse
async def khoa(req, bit: str, thuat_toan: str):
    if thuat_toan != "rsa":
        yield signals(
            khoa=b64e(
                get_random_bytes(int(bit)),
            ),
        )
    else:
        key = RSA.generate(int(bit) * 8)

        yield signals(
            khoa=key.publickey().export_key(format="PEM").decode("ascii"),
            khoa_priv=key.export_key(
                format="PEM",
                pkcs=8,
                protection="scryptAndAES128-CBC",
                passphrase="put-a-real-pass-here",
            ).decode("ascii"),
        )


serve()
