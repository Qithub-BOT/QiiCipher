# パスフレーズありの公開鍵・秘密鍵ペア置き場（動作テスト用）

- `ssh -V`: OpenSSH_8.4p1, OpenSSL 1.1.1k  25 Mar 2021
  - パスフレーズ: `luvqiitan`
  - ed25519 ペア
    - 作成方法: `ssh-keygen -t ed25519 -C "your_email@example.com" -f id_ed25519 -N "luvqiitan"`
    - `id_ed25519`: 秘密鍵（パスレーズあり: `luvqiitan`）
    - `id_ed25519.pub`: 公開鍵
      - フィンガープリント: `SHA256:ZtJnn/z5j98vub7GujMe9NxAKqZyBhvzvWM4jVEHlHk`
  - RSA
    - 作成方法: `ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f id_rsa -N "luvqiitan"`
    - `id_rsa`: 秘密鍵（パスレーズあり: `luvqiitan`）
    - `id_rsa.pub`: 公開鍵
      - フィンガープリント: `SHA256:HPaNMtIjHXAqIIY/hvSfWBJ2L5i4Fc/B8V+ZOYVLwcw your_email@example.com`

## 注意

**このディレクトリの公開鍵・秘密鍵はテスト用です**。動作テスト目的以外で使うと `pͪoͣnͬpͣoͥnͭpͣa͡inͥ` な事になります。
