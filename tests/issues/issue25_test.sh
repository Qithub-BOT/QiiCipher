#shellcheck shell=sh

# md5s は md5sum/md5 のラッパー関数です.
md5s() {
    if type md5sum 1>/dev/null 2>/dev/null; then
        printf "%s" "$1" | md5sum | awk '{ print $1 }'
        return $?
    fi

    if type md5 1>/dev/null 2>/dev/null; then
        md5 -q -s "$1"
        return $?
    fi

    echo >&2 'MD5 ハッシュ関数がありません。'
    exit 1
}

Describe 'md5s'
    It 'should return MD5 hash of the arg 1'
        When call md5s 'hoge'

        The output should equal 'ea703e7aa1efda0064eaa507d9e8ab7e'
        The status should be success
    End
End
