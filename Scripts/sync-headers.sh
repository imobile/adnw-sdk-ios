#!/bin/bash
#
# ImobileSdkAds.xcframework の公開ヘッダから、Swift Package Manager 用の
# Sources/ImobileSdkAds/include/ を再生成する。
#
# xcframework を差し替えたら必ず実行すること。生成物はコミット対象。
#
set -euo pipefail

cd "$(dirname "$0")/.."

XCFRAMEWORK="ImobileSdkAds.xcframework"
MODULE="ImobileSdkAds"
INCLUDE_DIR="Sources/${MODULE}/include"
UMBRELLA="${MODULE}-umbrella.h"

# --- 1. スライス間でヘッダが一致していることを確認 -------------------------
SLICES=()
while IFS= read -r line; do
    SLICES+=("$line")
done < <(find "$XCFRAMEWORK" -mindepth 1 -maxdepth 1 -type d | sort)

if [ "${#SLICES[@]}" -eq 0 ]; then
    echo "error: ${XCFRAMEWORK} にスライスが見つかりません" >&2
    exit 1
fi

REFERENCE="${SLICES[0]}/Headers"
for slice in "${SLICES[@]:1}"; do
    if ! diff -r "$REFERENCE" "${slice}/Headers" > /dev/null; then
        echo "error: スライス間でヘッダが一致しません" >&2
        diff -r "$REFERENCE" "${slice}/Headers" >&2 || true
        exit 1
    fi
done

# --- 2. ヘッダ一覧を収集 ---------------------------------------------------
HEADERS=()
while IFS= read -r header; do
    HEADERS+=("$(basename "$header")")
done < <(find "$REFERENCE" -name '*.h' -type f | sort)

if [ "${#HEADERS[@]}" -eq 0 ]; then
    echo "error: ${REFERENCE} にヘッダが見つかりません" >&2
    exit 1
fi

# --- 3. include/ を作り直す ------------------------------------------------
rm -rf "$INCLUDE_DIR"
mkdir -p "${INCLUDE_DIR}/${MODULE}"

# 3a. 実体のヘッダを ${MODULE}/ 配下に配置する。
#     xcframework 内のヘッダは #import "Xxx.h" 形式で相互参照しているため、
#     同一ディレクトリに固めて置く必要がある。
#
#     また、公開ヘッダは Foundation / UIKit を自前で import していない。
#     CocoaPods 経由では利用側が先に UIKit を読み込んでいる前提で成立していたが、
#     SPM ではヘッダ単体でコンパイルされる経路があるため、各ヘッダの先頭に
#     システムフレームワークの import を補ってから配置する。
#     （内容の変更はこの補完のみ。宣言そのものには一切手を加えない）
for header in "${HEADERS[@]}"; do
    {
        echo "// 先頭 3 行は Scripts/sync-headers.sh が補完しています。"
        echo "#import <Foundation/Foundation.h>"
        echo "#import <UIKit/UIKit.h>"
        cat "${REFERENCE}/${header}"
    } > "${INCLUDE_DIR}/${MODULE}/${header}"
done

# 3b. アンブレラヘッダ。module map から参照する唯一の入り口。
{
    echo "// このファイルは Scripts/sync-headers.sh が生成します。直接編集しないこと。"
    echo ""
    for header in "${HEADERS[@]}"; do
        echo "#import \"${header}\""
    done
} > "${INCLUDE_DIR}/${MODULE}/${UMBRELLA}"

# 3c. module map。
{
    echo "// このファイルは Scripts/sync-headers.sh が生成します。直接編集しないこと。"
    echo "module ${MODULE} {"
    echo "    header \"${MODULE}/${UMBRELLA}\""
    echo "    export *"
    echo "}"
} > "${INCLUDE_DIR}/module.modulemap"

# 3d. include/ 直下への転送ヘッダ。
#     利用側が #import "ImobileSdkAds.h" と書いても解決できるようにする。
for header in "${HEADERS[@]}"; do
    {
        echo "// このファイルは Scripts/sync-headers.sh が生成します。直接編集しないこと。"
        echo "#import <${MODULE}/${header}>"
    } > "${INCLUDE_DIR}/${header}"
done

echo "generated ${INCLUDE_DIR} (${#HEADERS[@]} headers)"
