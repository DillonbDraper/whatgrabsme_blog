# Terminal Benchmark Skill

Use this script to turn raw terminal benchmark output into consistent markdown tables and write them into `content/tech/benchmarks.md`.

There are two scripts:

- `scripts/terminal_benchmark_skill.pl`: parser/updater (expects separate files)
- `scripts/terminal_benchmark_wrapper.pl`: wrapper for a single pasted input file with section headers

## Inputs

- Kitty benchmark raw text
- vtebench raw text
- Hyperfine startup raw text (normal mode)
- Hyperfine startup raw text (optional client/server mode)

For wrapper mode, use one file with bracket headers:

```text
[kitty]
... raw kitty output ...

[vtebench]
... raw vtebench output ...

[startup-normal]
... raw hyperfine output ...

[startup-client]
... raw hyperfine output ...
```

`[startup-client]` is optional.

## Quick Wrapper Flow

```bash
perl scripts/terminal_benchmark_wrapper.pl --print-template
```

```bash
perl scripts/terminal_benchmark_wrapper.pl \
  --emulator "Foot" \
  --input /path/to/foot-paste.txt \
  --output content/tech/benchmarks.md
```

Preview without writing:

```bash
perl scripts/terminal_benchmark_wrapper.pl \
  --emulator "Foot" \
  --input /path/to/foot-paste.txt \
  --stdout
```

## Usage

```bash
perl scripts/terminal_benchmark_skill.pl \
  --emulator "Foot" \
  --kitty-file /path/to/foot-kitty.txt \
  --vte-file /path/to/foot-vtebench.txt \
  --startup-normal-file /path/to/foot-startup.txt \
  --startup-client-file /path/to/foot-startup-client.txt \
  --output content/tech/benchmarks.md
```

## Behavior

- Generates markdown with `####` subsection headings.
- Replaces an existing `## <Emulator> Emulator Benchmarks` section if present.
- Appends a new section if that emulator does not yet exist.

## Preview Without Writing

```bash
perl scripts/terminal_benchmark_skill.pl \
  --emulator "Foot" \
  --kitty-file /path/to/foot-kitty.txt \
  --vte-file /path/to/foot-vtebench.txt \
  --startup-normal-file /path/to/foot-startup.txt \
  --startup-client-file /path/to/foot-startup-client.txt \
  --stdout
```
