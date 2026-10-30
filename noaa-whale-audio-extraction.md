# NOAA Humpback Vocalization Extraction

## Objective

Retrieve a documented NOAA passive acoustic recording and extract a distinct humpback whale vocalization as an uncompressed WAV for close listening and subsequent acoustic examination.

## Source verification

**Project:** NOAA–U.S. Navy SanctSound  
**Site:** CI02_05, western Channel Islands, California  
**Recording date:** October 14, 2020 (filename timestamp)  
**Source:** NOAA-labeled humpback whale song clip

- [NOAA Passive Acoustic Data Archive](https://www.ncei.noaa.gov/products/passive-acoustic-data)
- [Official SanctSound metadata — CC0 1.0](https://www.fisheries.noaa.gov/inport/item/80343/full-list)

The western Channel Islands are part of the productive California Current ecosystem. October falls within the latter part of the regional humpback feeding season.

## 1. Retrieve the source

```bash
cd /Users/Shared
```

```bash
gcloud storage cp 'gs://noaa-passive-bioacoustic/sanctsound/products/sound_clips/ci02/sanctsound_ci02_05_sound_clips/data/SanctSound_CI02_05_humpbackwhalesong_20201014T134727Z.wav' .
```

## 2. Document source integrity

```bash
shasum -a 256 SanctSound_CI02_05_humpbackwhalesong_20201014T134727Z.wav
```

## 3. Extract selected vocalization

**Selected interval:** 18.48–31.48 seconds (13 seconds)

```bash
ffmpeg -i SanctSound_CI02_05_humpbackwhalesong_20201014T134727Z.wav -ss 18.48 -t 13 -acodec pcm_s24le whale_call_excerpt_final.wav
```

## 4. Verify output

```bash
ffprobe -v error -show_entries format=duration:stream=codec_name,sample_rate,channels,bits_per_sample -of default=noprint_wrappers=1 whale_call_excerpt_final.wav
```

**Expected output:** 13 seconds, 24-bit PCM WAV, 48 kHz, mono.

## 5. Acoustic quality check

Open the extracted file in Audacity.

- Listen to the complete vocalization.
- Inspect waveform and spectrogram.
- Check for truncation, clipping, or unintended artifacts.

**Scope:** This is a targeted extraction for close listening, not a statistically representative sample or behavioral interpretation.
