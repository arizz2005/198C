#
# This skeleton will guide you in preparing a suitable Makefile
# for this challenge.
#

#
# Define your Makefile variables here.  They should include:
#
# INPUTS: The names of the input files, as seen from this folder,
#   e.g., input/file.in (etc.).  The make function "wildcard" will
#   be useful for this.
#
# OUTPUTS: The names of the corresponding output files, e.g.,
#   output/file.out.  These can be constructed from INPUTS using
#   the make function "patsubst".  Note that patsubst can find and
#   copy over a match in the middle of a string, not just at the ends.
#   For example, $(patsubst a%b,c%d,axyzb afoob) will produce cxyzd cfood.
#
# NUMLINES: This should be set to the default number of lines for
#   copysome to copy.
#
# You may define additional variables as you see fit, but no more are
# necessary for this challenge.
#


#
# Define your rules here.  You will need rules for these targets
# (which the auto-grader will check!):
#
# all: This should be the first rule, and should have the output files
#   as its prerequisites.
#
# A static pattern rule for building the output files:  The first part
# should restrict the rule to apply to only the output files.  The target will
# be a pattern that matches an output file, and the first prerequisite will be
# the pattern for the corresponding input file.  Other prerequisites are
# copysome (the program), since you need it built before you can run it, and
# output (that is, the output directory), since that directory needs to exist
# for receiving the output files.  The recipe should run copysome on the first
# prerequisite (the make automatic variable $< is a way to name that) to build
# the target (the make automatic variable $@ is a way to name that).  Don't
# forget to mention NUMLINES as appropriate in the command to run copysome.
#
# obj/copysome.o: A rule to build this from src/copysome.c
#
# copysome:  A rule to build this from obj/copysome.o
#
# output: A rule to create the output directory.  This has no prerequisites.
#   For the recipe, mkdir -p will be helpful.
#
# clean:  This has no prerequisites and should remove the output directory and
#   all of its contents.  It should also remove copysome and obj/copysome.o.
#
NUMLINES = 10
INP = $(wildcard input/*.in)
OUT = $(patsubst input/%.in,output/%.out,$(INP))

all:$(OUT)

output/%.out: input/%.in copysome /output
	./copysome -n $(NUMLINES) $< $@

obj/copysome.o: src/copysome.c
	gcc -c src/copysome.c -o obj/copysome.o


/output: copysome clean
	mkdir -p output

copysome: obj/copysome.o
	gcc obj/copysome.o -o copysome


clean:
	rm -rf output
