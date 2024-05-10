use strict;
use warnings;

use Class::Struct;
use Math::Trig;

use constant FREQ => 0.1;

struct(RGB => [r => '$', g => '$', b => '$']);

# frequency, i
sub rainbow {
  my $color = RGB->new;

  my $frequency = $_[0];
  my $i = $_[1];

  $color->r(int(sin($frequency * $i) * 127 + 128));
  $color->g(int(sin($frequency * $i + 2 * pi / 3) * 127 + 128));
  $color->b(int(sin($frequency * $i + 4 * pi / 3) * 127 + 128));

  return $color;
}

# c, rgb
sub putc_with_rgb {
  my $c = $_[0];

  my $r = $_[1]->r;
  my $g = $_[1]->g;
  my $b = $_[1]->b;

  print "\e[38;2;$r;$g;${b}m$c\e[0m";
}

my $argc = scalar(@ARGV);

if ($argc > 0) {
  my $arg = $ARGV[0];
  
  my $i = 0;
  foreach my $char (split //, $arg) {
    putc_with_rgb($char, rainbow(FREQ, $i));

    $i++;
  }
}