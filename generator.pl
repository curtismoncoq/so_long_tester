#!/usr/bin/perl
use strict;
use warnings;

# Open a new file for writing
open my $fh, '>', 'maps/file.ber' or die "Could not open file: $!";

# Define the size of the map
my $width = int(rand(50)) + 5;
my $height = int(rand(30)) + 5;

# Create an empty map
my @map;
for my $i (0..$height-1) {
	$map[$i] = [ ('0') x $width ];
}

# Surround the map with walls
$map[$_][0] = $map[$_][$width-1] = '1' for 0..$height-1;
$map[0][$_] = $map[$height-1][$_] = '1' for 0..$width-1;

# Place the player and exit at random positions
my @positions = ('P', 'E');
foreach my $pos (@positions) {
	my ($x, $y);
	do {
		$x = int(rand($height-2))+1;
		$y = int(rand($width-2))+1;
	} while ($map[$x][$y] ne '0');
	$map[$x][$y] = $pos;
}

# Place a random number of collectibles and walls at random positions
my $num_collectibles = int(rand($height * $width / 5)) + 1;
my $num_walls = int(rand($height * $width / 8)) + 1;
my $num_opps = int(rand($height * $width / 20)) + 1;
for (1..$num_collectibles) {
	my ($x, $y);
	do {
		$x = int(rand($height-2))+1;
		$y = int(rand($width-2))+1;
	} while ($map[$x][$y] ne '0');
	$map[$x][$y] = 'C';
}
for (1..$num_walls) {
	my ($x, $y);
	do {
		$x = int(rand($height-2))+1;
		$y = int(rand($width-2))+1;
	} while ($map[$x][$y] ne '0');
	$map[$x][$y] = '1';
}
for (1..$num_opps) {
	my ($x, $y);
	do {
		$x = int(rand($height-2))+1;
		$y = int(rand($width-2))+1;
	} while ($map[$x][$y] ne '0');
	$map[$x][$y] = 'X';
}

# Write the map to the file
foreach my $row (@map) {
	print $fh join('', @$row), "\n";
}

# Close the file
close $fh;