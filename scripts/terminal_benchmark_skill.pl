#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Getopt::Long qw(GetOptions);

my %opt = (
    startup_client_label => 'Client (server alive)',
    output               => 'content/tech/benchmarks.md',
    stdout               => 0,
);

GetOptions(
    'emulator=s'             => \$opt{emulator},
    'kitty-file=s'           => \$opt{kitty_file},
    'vte-file=s'             => \$opt{vte_file},
    'startup-normal-file=s'  => \$opt{startup_normal_file},
    'startup-client-file=s'  => \$opt{startup_client_file},
    'startup-client-label=s' => \$opt{startup_client_label},
    'output=s'               => \$opt{output},
    'stdout!'                => \$opt{stdout},
) or die "Invalid arguments\n";

die "--emulator is required\n" unless defined $opt{emulator} && length $opt{emulator};

my $kitty_text          = read_optional($opt{kitty_file});
my $vte_text            = read_optional($opt{vte_file});
my $startup_normal_text = read_optional($opt{startup_normal_file});
my $startup_client_text = read_optional($opt{startup_client_file});

my $kitty_rows = parse_kitty($kitty_text);
my $vte_rows = parse_vte($vte_text);
my $startup_normal = parse_startup($startup_normal_text);
my $startup_client = parse_startup($startup_client_text);

if (!@$kitty_rows && !@$vte_rows && !$startup_normal && !$startup_client) {
    die "No benchmark data parsed. Check input files and formats.\n";
}

my $section = render_markdown(
    $opt{emulator},
    $kitty_rows,
    $vte_rows,
    $startup_normal,
    $startup_client,
    $opt{startup_client_label},
);

if ($opt{stdout}) {
    print $section;
    exit 0;
}

my $existing = '';
if (-f $opt{output}) {
    open my $in, '<:encoding(UTF-8)', $opt{output} or die "Cannot read $opt{output}: $!\n";
    local $/;
    $existing = <$in>;
    close $in;
}

my $updated = upsert_section($existing, $opt{emulator}, $section);
open my $out, '>:encoding(UTF-8)', $opt{output} or die "Cannot write $opt{output}: $!\n";
print {$out} $updated;
close $out;

print "Updated $opt{output}\n";
exit 0;

sub read_optional {
    my ($path) = @_;
    return '' unless defined $path && length $path;
    open my $fh, '<:encoding(UTF-8)', $path or die "Cannot read $path: $!\n";
    local $/;
    my $content = <$fh>;
    close $fh;
    return $content // '';
}

sub parse_kitty {
    my ($text) = @_;
    my @rows;
    for my $line (split /\n/, $text // '') {
        if ($line =~ /^\s*(.+?)\s*:\s*([0-9.]+(?:ms|s))\s*\@\s*([0-9.]+)\s*MB\/s\s*$/) {
            push @rows,
              {
                test       => $1,
                time       => $2,
                throughput => $3,
              };
        }
    }
    return \@rows;
}

sub parse_vte {
    my ($text) = @_;
    my @rows;
    while (
        $text =~ /\s*([a-zA-Z0-9_]+)\s*\((\d+)\s+samples\s+\@\s*([^)]+)\):\s*\n\s*([0-9.]+ms)\s+avg\s+\(90%\s*<\s*([0-9.]+ms)\)\s+\+\-([0-9.]+ms)/g
      )
    {
        push @rows,
          {
            test    => $1,
            samples => $2,
            payload => $3,
            avg     => $4,
            p90     => "< $5",
            std     => $6,
          };
    }
    return \@rows;
}

sub parse_startup {
    my ($text) = @_;
    return undef unless defined $text && $text =~ /\S/;

    $text =~ s/±/+-/g;
    $text =~ s/…/.../g;

    my ($mean, $std, $user, $system) =
      $text =~ /Time\s*\(mean.*?\):\s*([0-9.]+\s*[a-zA-Z]+)\s*\+\-\s*([0-9.]+\s*[a-zA-Z]+)\s*\[User:\s*([0-9.]+\s*[a-zA-Z]+),\s*System:\s*([0-9.]+\s*[a-zA-Z]+)\]/s;
    my ($min, $max, $runs) =
      $text =~ /Range\s*\(min.*?max\):\s*([0-9.]+\s*[a-zA-Z]+)\s*\.\.\.\s*([0-9.]+\s*[a-zA-Z]+)\s*(\d+)\s+runs/s;

    return undef unless defined $mean && defined $min;

    return {
        mean   => $mean,
        std    => $std,
        user   => $user,
        system => $system,
        min    => $min,
        max    => $max,
        runs   => $runs,
    };
}

sub render_markdown {
    my ($emulator, $kitty_rows, $vte_rows, $startup_normal, $startup_client, $startup_client_label) = @_;
    my @lines = ("## $emulator Emulator Benchmarks", '');
    my $section_num = 1;

    if (@$kitty_rows) {
        push @lines,
          "#### $section_num) Kitty Benchmark Results",
          '',
          '| Emulator | Test                      | Time     | Throughput (MB/s) |',
          '|----------|---------------------------|----------|-------------------|';
        for my $row (@$kitty_rows) {
            push @lines,
              sprintf('| %s | %-25s | %-8s | %-17s |',
                $emulator, $row->{test}, $row->{time}, $row->{throughput});
        }
        push @lines, '';
        $section_num++;
    }

    if (@$vte_rows) {
        push @lines,
          "#### $section_num) vtebench Results",
          '',
          '| Emulator | Test                          | Samples | Payload  | Avg Time | P90 Time | Std Dev |',
          '|----------|-------------------------------|---------|----------|----------|----------|---------|';
        for my $row (@$vte_rows) {
            push @lines,
              sprintf('| %s | %-29s | %-7s | %-8s | %-8s | %-8s | %-7s |',
                $emulator, $row->{test}, $row->{samples}, $row->{payload}, $row->{avg}, $row->{p90}, $row->{std});
        }
        push @lines, '';
        $section_num++;
    }

    if ($startup_normal) {
        push @lines,
          "#### $section_num) Startup Time (hyperfine, normal mode)",
          '',
          '| Emulator | Mode   | Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |',
          '|----------|--------|-----------|---------|----------|----------|------|----------|------------|',
          sprintf('| %s | Normal | %-9s | %-7s | %-8s | %-8s | %-4s | %-8s | %-10s |',
            $emulator,
            $startup_normal->{mean},
            $startup_normal->{std},
            $startup_normal->{min},
            $startup_normal->{max},
            $startup_normal->{runs},
            $startup_normal->{user},
            $startup_normal->{system}),
          '';
        $section_num++;
    }

    if ($startup_client) {
        push @lines,
          "#### $section_num) Startup Time (hyperfine, client mode with server running)",
          '',
          '| Emulator | Mode | Mean Time | Std Dev | Min Time | Max Time | Runs | User CPU | System CPU |',
          '|----------|------|-----------|---------|----------|----------|------|----------|------------|',
          sprintf('| %s | %s | %-9s | %-7s | %-8s | %-8s | %-4s | %-8s | %-10s |',
            $emulator,
            $startup_client_label,
            $startup_client->{mean},
            $startup_client->{std},
            $startup_client->{min},
            $startup_client->{max},
            $startup_client->{runs},
            $startup_client->{user},
            $startup_client->{system}),
          '';
    }

    return join("\n", @lines) . "\n";
}

sub upsert_section {
    my ($existing, $emulator, $section) = @_;
    my $quoted = quotemeta($emulator);
    my $pattern = qr/^##\s+$quoted\s+Emulator\s+Benchmarks\n.*?(?=^##\s+|\z)/ms;

    if ($existing =~ $pattern) {
        $existing =~ s/$pattern/$section/ms;
        $existing =~ s/\s+\z/\n/s;
        return $existing;
    }

    if ($existing =~ /\S/) {
        $existing =~ s/\s+\z/\n\n/s;
        return $existing . $section;
    }
    return $section;
}
