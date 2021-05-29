# パスフレーズなしの公開鍵・秘密鍵ペア置き場（動作テスト用）

- `ssh -V`: OpenSSH_8.4p1, OpenSSL 1.1.1k  25 Mar 2021
  - パスフレーズ: なし
  - ed25519 ペア
    - 作成方法: `ssh-keygen -t ed25519 -C "your_email@example.com" -f id_ed25519 -N ""`
    - `id_ed25519`: 秘密鍵（パスレーズなし）
    - `id_ed25519.pub`: 公開鍵
      - フィンガープリント: `SHA256:po0czerGHS70Iduqvb/7Gz7fYgExzHysSELHifJ42gY your_email@example.com`
  - RSA
    - 作成方法: `ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f id_rsa -N ""`
    - `id_rsa`: 秘密鍵（パスレーズなし）
    - `id_rsa.pub`: 公開鍵
      - フィンガープリント: `SHA256:vCih7no5L4xAaAv1MZ7d2NwbccciXA5zU0JQL0xdLUQ your_email@example.com`

## 注意

**このディレクトリの公開鍵・秘密鍵はテスト用です**。動作テスト目的以外で使うと `pͪoͣnͬpͣoͥnͭpͣa͡inͥ` な事になります。
