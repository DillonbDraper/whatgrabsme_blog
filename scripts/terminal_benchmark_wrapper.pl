#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Getopt::Long qw(GetOptions);
use FindBin qw($Bin);
use File::Temp qw(tempfile);

my %opt = (
    output               => 'content/tech/benchmarks.md',
    startup_client_label => 'Client (server alive)',
    stdout               => 0,
    print_template       => 0,
);

GetOptions(
    'emulator=s'             => \$opt{emulator},
    'input=s'                => \$opt{input},
    'output=s'               => \$opt{output},
    'startup-client-label=s' => \$opt{startup_client_label},
    'stdout!'                => \$opt{stdout},
    'print-template!'        => \$opt{print_template},
) or die "Invalid arguments\n";

if ($opt{print_template}) {
    print <<'EOF';
[kitty]
Only ASCII chars         : ... @ ... MB/s

[vtebench]
cursor_motion (... samples @ ... MiB):
  ...ms avg (90% < ...ms) +-...ms

[startup-normal]
Time (mean ± σ): ... [User: ..., System: ...]
Range (min … max): ... ... ... runs

[startup-client]
Time (mean ± σ): ... [User: ..., System: ...]
Range (min … max): ... ... ... runs
EOF
    exit 0;
}

die "--emulator is required\n" unless defined $opt{emulator} && length $opt{emulator};
die "--input is required (or use --print-template)\n" unless defined $opt{input} && length $opt{input};

my $text = read_text($opt{input});
my $sections = parse_sections($text);

if (!%$sections) {
    die "No section headers found. Use [kitty], [vtebench], [startup-normal], [startup-client].\n";
}

my $parser = "$Bin/terminal_benchmark_skill.pl";
die "Cannot find parser script at $parser\n" unless -f $parser;

my @cmd = (
    $^X,
    $parser,
    '--emulator',
    $opt{emulator},
    '--startup-client-label',
    $opt{startup_client_label},
);

if ($opt{stdout}) {
    push @cmd, '--stdout';
} else {
    push @cmd, '--output', $opt{output};
}

my @temp_files;
for my $key (qw(kitty vtebench startup-normal startup-client)) {
    next unless exists $sections->{$key} && $sections->{$key} =~ /\S/;
    my ($fh, $path) = tempfile('bench-XXXXXX', SUFFIX => '.txt', UNLINK => 1);
    binmode($fh, ':encoding(UTF-8)');
    print {$fh} $sections->{$key};
    close $fh;
    push @temp_files, $path;

    if ($key eq 'kitty') {
        push @cmd, '--kitty-file', $path;
    } elsif ($key eq 'vtebench') {
        push @cmd, '--vte-file', $path;
    } elsif ($key eq 'startup-normal') {
        push @cmd, '--startup-normal-file', $path;
    } elsif ($key eq 'startup-client') {
        push @cmd, '--startup-client-file', $path;
    }
}

my $status = system @cmd;
if ($status != 0) {
    my $code = $status >> 8;
    die "Parser command failed with exit code $code\n";
}

exit 0;

sub read_text {
    my ($path) = @_;
    open my $fh, '<:encoding(UTF-8)', $path or die "Cannot read $path: $!\n";
    local $/;
    my $content = <$fh>;
    close $fh;
    return $content // '';
}

sub parse_sections {
    my ($text) = @_;
    my %sections;
    my $current;

    for my $line (split /\n/, $text) {
        if (my $name = normalize_header($line)) {
            $current = $name;
            next;
        }
        next unless defined $current;
        $sections{$current} .= "$line\n";
    }

    for my $k (keys %sections) {
        $sections{$k} = trim($sections{$k});
    }

    return \%sections;
}

sub normalize_header {
    my ($line) = @_;
    return undef unless defined $line;
    return undef unless $line =~ /^\s*\[\s*([^\]]+?)\s*\]\s*$/;
    my $h = lc $1;
    $h =~ s/\s+/-/g;
    $h =~ s/_/-/g;

    return 'kitty'          if $h eq 'kitty';
    return 'vtebench'       if $h eq 'vtebench' || $h eq 'vte';
    return 'startup-normal' if $h eq 'startup-normal' || $h eq 'startup' || $h eq 'normal-startup';
    return 'startup-client' if $h eq 'startup-client' || $h eq 'client-startup' || $h eq 'startup-client-server';
    return undef;
}

sub trim {
    my ($value) = @_;
    $value =~ s/^\s+//s;
    $value =~ s/\s+\z//s;
    return $value;
}
