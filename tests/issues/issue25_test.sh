#shellcheck shell=bash

# md5s は md5sum/md5 のラッパー関数です.
md5s() {
    if [ -e "$(which md5sum)" ]; then
        echo "$1" | md5sum | awk '{ print $1 }'
        return $?
    fi

    if [ -e "$(which md5)" ]; then
        md5 -q -s "$1"
        return $?
    fi

    echo >&2 'MD5 ハッシュ関数がありません。'
    exit 1
}

Describe 'md5s'
    It 'should return MD5 hash of the arg 1'
        When call md5s 'hoge'

        The output should equal 'c59548c3c576228486a1f0037eb16a1b'
        The status should be success
    End
End
