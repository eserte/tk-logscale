# -*- perl -*-

#
# $Id: LogScale.pm,v 1.1 1999/12/19 20:25:48 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 1999 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@cs.tu-berlin.de
# WWW:  http://user.cs.tu-berlin.de/~eserte/
#

package Tk::LogScale;
use strict;
use vars qw($VERSION @ISA);
use base qw(Tk::Derived Tk::Scale);
use Tie::Watch;
Construct Tk::Widget 'LogScale';

$VERSION = '0.01';

sub Populate {
    my($w, $args) = @_;
    $args->{-showvalue} = 0;
    $w->ConfigSpecs
      (-variable => ['METHOD', 'variable', 'Variable', undef]);
    $w->SUPER::Populate($args);
}

sub variable {
    my($w, $val) = @_;
    if (@_ < 2) {
	$w->Tk::Scale::cget(-variable);
    } else {
	my $scalevar = $val;
	$w->{WatchVar} = new Tie::Watch
	  (-variable => $scalevar,
	   -debug    => 1,
	   -fetch    => sub { logfetch($val, @_) },
	   -store    => sub { logstore($val, @_) },
	  );
	$w->Tk::Scale::configure(-variable => $scalevar);
    }
}

sub logfetch {
    my($scalevar, $self) = @_;
#    $$scalevar = exp($newval);
#use Data::Dumper; print STDERR "Line " . __LINE__ . ", File: " . __FILE__ . "\n" . Data::Dumper->Dumpxs([$self],[]); # XXX

    $self->Fetch;
#    exp($$scalevar);
}

sub logstore {
    my($scalevar, $self, $newval) = @_;
#use Data::Dumper; print STDERR "Line " . __LINE__ . ", File: " . __FILE__ . "\n" . Data::Dumper->Dumpxs([$self],[]); # XXX
    $$scalevar = int(exp($newval));
    $self->Store($newval);
}

1;
__END__

=head1 NAME

Tk::LogScale - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Tk::LogScale;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Tk::LogScale was created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head1 AUTHOR

Slaven Rezic <eserte@cs.tu-berlin.de>

=head1 SEE ALSO

L<Tk::Scale>.

=cut
