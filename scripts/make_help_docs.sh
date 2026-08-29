#!/usr/bin/env bash
set -euo pipefail

# ponytail: uses the globally installed ft (cargo install fibertools-rs); override with FT=/path/to/ft
FT=${FT:-ft}

out="src/fibertools/help.md"
echo "# Help pages for fibertools subcommands" >$out
echo "" >>$out

for subcommand in "" "predict-m6a" "add-nucleosomes" "fire" "extract" "center" "footprint" "qc" "track-decorators" "pileup" "clear-kinetics" "strip-basemods" "validate" "call-peaks"; do
    echo $subcommand

    echo "## \`ft $subcommand\`" >>$out
    echo '```console' >>$out
    $FT $subcommand -h >>$out
    echo '```' >>$out
    echo "" >>$out
done
