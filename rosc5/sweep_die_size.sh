#!/usr/bin/env bash
# sweep_die_size.sh — minimum-die-size sweep for zTimer
#
# Usage:
#     ./sweep_die_size.sh
#

set -u
set -o pipefail

# ---------------- configuration -------------------------------------------
ORIG_CONFIG="librelane/config.yaml"
SWEEP_CONFIG="librelane/config.sweep.yaml"
SUMMARY="sweep_summary.txt"
MARGIN=10          # core inset from die edge on each side (microns)

#PDK="gf180mcuD"
#PDK_ROOT="/Design/snapaa/TO/gf180mcu-caravel-template/ztimer/../gf180mcu"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PDK="${PDK:-gf180mcuD}"
PDK_ROOT="${PDK_ROOT:-${SCRIPT_DIR}/../gf180mcu}"


# square die sizes in microns, descending
SIZES=(150 125 100 80 60 50 40 30)

if [[ ! -f "$ORIG_CONFIG" ]]; then
    echo "ERROR: $ORIG_CONFIG not found. Run from the ztimer directory." >&2
    exit 1
fi

# Header
{
    printf "%-12s | %-6s | %-32s | %s\n" "DIE_SIZE" "MARK" "LAST_STEP" "RUN"
    printf "%s\n" \
"-------------+--------+----------------------------------+---------------------------"
} | tee "$SUMMARY"

for size in "${SIZES[@]}"; do
    core_max=$(( size - MARGIN ))

    # Sanity: skip sizes too small for the chosen margin
    if (( core_max <= MARGIN )); then
        printf "%-12s | %-6s | %-32s | %s\n" \
               "${size}x${size}" "SKIP" "core_inset_too_large" "-" \
               | tee -a "$SUMMARY"
        continue
    fi

    # Build a sweep config: copy the original, swap DIE_AREA + CORE_AREA lines.
    # Anchored at ^ so commented variants are untouched.
    sed -E \
        -e "s|^DIE_AREA: .*|DIE_AREA: [0, 0, ${size}, ${size}]|" \
        -e "s|^CORE_AREA: .*|CORE_AREA: [${MARGIN}, ${MARGIN}, ${core_max}, ${core_max}]|" \
        "$ORIG_CONFIG" > "$SWEEP_CONFIG"

    # Timestamp so we can pick out the RUN_* directory this iteration creates.
    t0=$(date +%s)

    # Quiet run — everything still logged under librelane/runs/RUN_*/
    librelane "$SWEEP_CONFIG" \
        --pdk "$PDK" \
        --pdk-root "$PDK_ROOT" \
        --manual-pdk \
        --skip KLayout.DRC \
        --skip Magic.DRC \
        > /dev/null 2>&1
    rc=$?

    # run directory created during this iteration
    run_dir=$(find librelane/runs -maxdepth 1 -type d -name 'RUN_*' \
              -newermt "@${t0}" -printf '%f\n' 2>/dev/null | sort | tail -n1)
    [[ -z "$run_dir" ]] && run_dir="(no run dir)"

    # last flow
    last_step="(none)"
    if [[ "$run_dir" != "(no run dir)" ]]; then
        last_step=$(ls -1 "librelane/runs/$run_dir" 2>/dev/null \
                    | grep -E '^[0-9]+-' | sort -V | tail -n1)
        [[ -z "$last_step" ]] && last_step="(no steps)"
    fi

    if [[ $rc -eq 0 ]]; then mark="PASS"; else mark="FAIL"; fi

    printf "%-12s | %-6s | %-32s | %s\n" \
           "${size}x${size}" "$mark" "$last_step" "$run_dir" \
           | tee -a "$SUMMARY"
done

rm -f "$SWEEP_CONFIG"

echo
echo "Done. Summary in $SUMMARY"
echo "Per-run logs under librelane/runs/RUN_*/"

