#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="${TMPDIR:-/tmp}/cf_por_seq_tb"
iverilog -g2005 -o "$OUT" \
  "$ROOT/hdl/gl/CF_POR_SEQ.v" \
  "$ROOT/verify/beh_model/CF_POR_SEQ_core.v" \
  "$ROOT/verify/beh_model/tb_CF_POR_SEQ.v"
vvp "$OUT"
