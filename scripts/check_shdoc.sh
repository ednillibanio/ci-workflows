#!/usr/bin/env bash

# @file check_shdoc.sh
# @brief Falha quando um entrypoint shell não tem o cabeçalho shdoc mínimo.
# @description
#   Confere, em cada arquivo recebido, as tags @file, @brief, @description e @example no
#   shdoc header rules. @file and @brief must have a value on the same line.
#
#   The header is the comment block immediately after the shebang, ending at the first non-comment, non-blank line.
#
#   Only tracked executable entrypoints (mode 100755) are checked. Libraries (100644) are excluded; check-exec-bit validates file modes.
#
# @arg $@ string Arquivos a conferir, relativos à raiz do repo.
# @flag --help,-h Show usage.
#
# @example
#   ./scripts/check_shdoc.sh docker/entrypoint.sh

set -euo pipefail

log_error() { echo "[ERROR] $*" >&2; }

usage() {
  cat <<'USAGE'
Usage: ./scripts/check_shdoc.sh <arquivo>...

Fail when an entrypoint (100755 no índice do git) does not have @file, @brief, @description and
@example in its shdoc header.
USAGE
}

# @description Print the comment header immediately following the shebang.
# @arg $1 string File path.
header() {
  awk 'NR == 1 && /^#!/ {next} /^[[:space:]]*#/ || /^[[:space:]]*$/ {print; next} {exit}' "$1"
}

# @description Check file tags and print one error line for each missing tag.
# @arg $1 string File path.
# @exitcode 0 Complete header.
# @exitcode 1 One or more tags are missing.
check_file() {
  local path="$1" head rc=0 tag
  head="$(header "${path}")"
  for tag in file brief; do
    if ! grep -qE "^#[[:space:]]*@${tag}[[:space:]]+[^[:space:]]" <<<"${head}"; then
      log_error "${path}: cabeçalho shdoc sem @${tag} com valor"
      rc=1
    fi
  done
  for tag in description example; do
    if ! grep -qE "^#[[:space:]]*@${tag}([[:space:]]|$)" <<<"${head}"; then
      log_error "${path}: cabeçalho shdoc sem @${tag}"
      rc=1
    fi
  done
  return "${rc}"
}

main() {
  case "${1:-}" in
  --help | -h)
    usage
    exit 0
    ;;
  esac

  local path mode failures=0 checked=0
  for path in "$@"; do
    mode="$(git ls-files -s -- "${path}" | awk '{print $1; exit}')"
    [[ "${mode}" == 100755 ]] || continue
    checked=$((checked + 1))
    check_file "${path}" || failures=$((failures + 1))
  done

  if ((failures > 0)); then
    log_error "${failures} de ${checked} entrypoint(s) sem o cabeçalho shdoc mínimo."
    exit 1
  fi
  echo "[INFO] ${checked} entrypoint(s) conferido(s); cabeçalhos shdoc completos."
}

main "$@"
