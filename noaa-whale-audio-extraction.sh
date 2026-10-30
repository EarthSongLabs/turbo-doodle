#!/usr/bin/env bash
# Reusable, interactive NOAA whale-audio excerpt workflow.
# Compatible with the Bash version supplied by macOS.
set -euo pipefail

say() { printf '\n%s\n' "$*"; }
fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }
ask() {
  local question="$1" answer
  printf '%s' "$question" >&2
  IFS= read -r answer || fail 'Input ended before setup was complete.'
  printf '%s' "$answer"
}
show_command() {
  printf '  '
  printf '%q ' "$@"
  printf '\n'
}
require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "Required command '$1' is not installed."
}

say 'NOAA whale-audio excerpt: guided command generator'
say 'This script does not verify licensing. Confirm source provenance and permissions in the NOAA metadata first.'

source_ref="$(ask 'Original file path, gs:// URI, or direct HTTPS URL: ')"
[[ -n "$source_ref" ]] || fail 'A source is required.'

workdir="$(ask "Working directory [$(pwd)]: ")"
workdir="${workdir:-$(pwd)}"
[[ "$workdir" = /* ]] || fail 'Please use an absolute working-directory path.'

start_seconds="$(ask 'Selection start time in seconds (e.g. 18.48): ')"
end_seconds="$(ask 'Selection end time in seconds (e.g. 31.48): ')"
numeric='^[0-9]+([.][0-9]+)?$'
[[ "$start_seconds" =~ $numeric && "$end_seconds" =~ $numeric ]] || fail 'Start and end must be positive decimal seconds.'
duration_seconds="$(awk -v s="$start_seconds" -v e="$end_seconds" 'BEGIN { if (e <= s) exit 1; printf "%.6f", e-s }')" || fail 'End time must be greater than start time.'

output_name="$(ask 'Output WAV filename [whale_excerpt.wav]: ')"
output_name="${output_name:-whale_excerpt.wav}"
[[ "$output_name" = *.wav && "$output_name" != */* && "$output_name" != '.' && "$output_name" != '..' ]] || fail 'Choose a .wav filename without directory separators.'

bitdepth="$(ask 'Output PCM bit depth: 16, 24, or 32 [24]: ')"
bitdepth="${bitdepth:-24}"
case "$bitdepth" in
  16) codec='pcm_s16le' ;;
  24) codec='pcm_s24le' ;;
  32) codec='pcm_s32le' ;;
  *) fail 'Choose 16, 24, or 32.' ;;
esac

license_ref="$(ask 'NOAA metadata/license page URL (optional, for manifest): ')"

case "$source_ref" in
  gs://*) source_kind='gcs' ;;
  https://*|http://*) source_kind='https' ;;
  *) source_kind='local' ;;
esac

if [[ "$source_kind" == 'local' ]]; then
  source_file="$source_ref"
  [[ -f "$source_file" ]] || fail "Local source file not found: $source_file"
else
  remote_path="${source_ref%%\?*}"
  source_name="${remote_path##*/}"
  [[ -n "$source_name" && "$source_name" != '.' && "$source_name" != '..' ]] || fail 'Cannot determine the source filename from this URI.'
  source_file="$workdir/raw/$source_name"
fi

output_file="$workdir/excerpts/$output_name"
manifest_file="$workdir/excerpts/${output_name%.wav}_manifest.txt"
[[ "$output_file" != "$source_file" ]] || fail 'Output cannot overwrite the source file.'

say 'Review the generated workflow:'
printf '  Source:   %s\n' "$source_ref"
printf '  Interval: %s to %s seconds (duration %s seconds)\n' "$start_seconds" "$end_seconds" "$duration_seconds"
printf '  Codec:    %s (source sample rate retained by default)\n' "$codec"
printf '  Output:   %s\n' "$output_file"

say 'Commands to run:'
if [[ "$source_kind" == 'gcs' ]]; then
  show_command mkdir -p "$workdir/raw" "$workdir/excerpts"
  show_command gcloud storage cp "$source_ref" "$source_file"
elif [[ "$source_kind" == 'https' ]]; then
  show_command mkdir -p "$workdir/raw" "$workdir/excerpts"
  show_command curl -fL "$source_ref" -o "$source_file"
else
  show_command mkdir -p "$workdir/excerpts"
fi
show_command shasum -a 256 "$source_file"
show_command ffprobe -v error -show_entries 'format=duration:stream=codec_name,sample_rate,channels,bits_per_sample' -of 'default=noprint_wrappers=1' "$source_file"
show_command ffmpeg -i "$source_file" -ss "$start_seconds" -t "$duration_seconds" -acodec "$codec" "$output_file"
show_command ffprobe -v error -show_entries 'format=duration:stream=codec_name,sample_rate,channels,bits_per_sample' -of 'default=noprint_wrappers=1' "$output_file"
show_command shasum -a 256 "$output_file"

say 'You may copy these generated commands. Nothing has been downloaded or altered.'
confirm="$(ask 'Execute this workflow now? [y/N]: ')"
case "$confirm" in y|Y|yes|YES) ;; *) say 'Preview only; no files changed.'; exit 0 ;; esac

require_command ffmpeg
require_command ffprobe
require_command shasum
case "$source_kind" in
  gcs) require_command gcloud ;;
  https) require_command curl ;;
esac

[[ ! -e "$output_file" ]] || fail "Output already exists: $output_file (choose a new output name)."
[[ ! -e "$manifest_file" ]] || fail "Manifest already exists: $manifest_file (choose a new output name)."

mkdir -p "$workdir/excerpts"
if [[ "$source_kind" != 'local' ]]; then
  mkdir -p "$workdir/raw"
  if [[ -e "$source_file" ]]; then
    reuse="$(ask "Downloaded source already exists. Reuse it without overwriting? [y/N]: ")"
    case "$reuse" in y|Y|yes|YES) ;; *) fail 'Stopped without replacing the source.' ;; esac
  elif [[ "$source_kind" == 'gcs' ]]; then
    gcloud storage cp "$source_ref" "$source_file"
  else
    curl -fL "$source_ref" -o "$source_file"
  fi
fi

say 'Source checksum and technical properties:'
shasum -a 256 "$source_file"
ffprobe -v error -show_entries 'format=duration:stream=codec_name,sample_rate,channels,bits_per_sample' -of 'default=noprint_wrappers=1' "$source_file"

say 'Extracting selected interval:'
ffmpeg -i "$source_file" -ss "$start_seconds" -t "$duration_seconds" -acodec "$codec" "$output_file"

say 'Output verification:'
ffprobe -v error -show_entries 'format=duration:stream=codec_name,sample_rate,channels,bits_per_sample' -of 'default=noprint_wrappers=1' "$output_file"
shasum -a 256 "$output_file"

{
  printf 'NOAA whale-audio extraction manifest\n'
  printf 'Source reference: %s\nLocal source: %s\nLicense/metadata reference: %s\n' "$source_ref" "$source_file" "${license_ref:-Not supplied - verify before reuse}"
  printf 'Start: %s seconds\nEnd: %s seconds\nDuration: %s seconds\n' "$start_seconds" "$end_seconds" "$duration_seconds"
  printf 'Output: %s\nCodec: %s\n' "$output_file" "$codec"
  printf '\nSource SHA-256:\n'; shasum -a 256 "$source_file"
  printf '\nOutput SHA-256:\n'; shasum -a 256 "$output_file"
  printf '\nFFmpeg version:\n'; ffmpeg -version | sed -n '1p'
  printf '\nNOTE: Confirm event boundaries by listening and spectrogram inspection in Audacity.\n'
} > "$manifest_file"

say "Completed. Manifest saved to: $manifest_file"
say 'Final step: open the excerpt in Audacity and check boundaries and acoustic quality.'
