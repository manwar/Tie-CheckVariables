#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Tie::CheckVariables;

my $error;
Tie::CheckVariables->on_error( sub { $error = 'This was a test' } );

tie my $age, 'Tie::CheckVariables', bless {}, 'CGI';

$age = 99;
is $error, undef;

$age = 'a';
is $error, undef;

$age = '01238';
is $error, undef;

$age = sub { 1 };
is $error, 'This was a test';

$age = bless {}, 'CGI';
is $error, 'This was a test';

done_testing;
